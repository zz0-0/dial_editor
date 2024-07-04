import 'dart:io';

import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/document_codec.dart';
import 'package:dial_editor/src/feature/editor/util/markdown_render.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditPart extends ConsumerStatefulWidget {
  final File file;
  const EditPart({super.key, required this.file});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPartState();
}

class _EditPartState extends ConsumerState<EditPart> {
  late Document document;
  late String fileString;
  List<Node> nodes = [];
  List<Widget> markdownWidgetList = [];
  int editingLineIndex = -1;

  @override
  void initState() {
    super.initState();
    fileString = widget.file.readAsStringSync();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    document = DocumentCodec(context).encode(fileString);
    nodes = document.children;
    markdownWidgetList = MarkdownRender().renderList(nodes);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildLineNumber(),
        _buildEditingArea(),
      ],
    );
  }

  double _getTextHeight(TextStyle textStyle, String text) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.height;
  }

  Widget _buildLineNumber() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: SizedBox(
        width: 30,
        child: ListView.builder(
          itemCount: nodes.length,
          itemBuilder: (context, index) {
            final textStyle = nodes[index].style;
            final lineHeight = _getTextHeight(textStyle, nodes[index].text);
            return Row(
              children: [
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: lineHeight == 19.0 ? 0.5 : 0,
                  ),
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: lineHeight,
                    child: Text(
                      "${index + 1}",
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEditingArea() {
    return Expanded(
      child: ListView.builder(
        itemCount: nodes.length,
        itemBuilder: (context, index) {
          return index == editingLineIndex
              ? _buildEditingWidget()
              : _buildRenderingWidget(index);
        },
      ),
    );
  }

  Widget _buildEditingWidget() {
    return Focus(
      onKeyEvent: (node, event) {
        if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
            event.logicalKey == LogicalKeyboardKey.backspace) {
          _onDelete();
        }

        if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
            event.logicalKey == LogicalKeyboardKey.arrowUp) {
          _onArrowUp();
        }

        if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
            event.logicalKey == LogicalKeyboardKey.arrowDown) {
          _onArrowDown();
        }

        return KeyEventResult.ignored;
      },
      child: EditableText(
        controller: nodes[editingLineIndex].controller,
        style: nodes[editingLineIndex].style,
        onChanged: (value) {
          _onChange(value);
        },
        onEditingComplete: () {
          _onEditingComplete();
        },
        focusNode: nodes[editingLineIndex].focusNode,
        cursorColor: Colors.blue,
        backgroundCursorColor: Colors.white,
      ),
    );
  }

  Widget _buildRenderingWidget(int index) {
    return GestureDetector(
      onTapUp: (details) {
        setState(() {
          editingLineIndex = index;
          nodes[editingLineIndex].controller.clear();
          nodes[editingLineIndex].controller.text =
              nodes[editingLineIndex].rawText;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            nodes[editingLineIndex].focusNode.requestFocus();
          });
        });
      },
      child: markdownWidgetList[index],
    );
  }

  void _onDelete() {
    if (nodes[editingLineIndex].text.isEmpty) {
      if (editingLineIndex > 0) {
        setState(() {
          nodes.removeAt(editingLineIndex);
          markdownWidgetList.removeAt(editingLineIndex);
          editingLineIndex--;
          fileString = document.toString();
          widget.file.writeAsStringSync(fileString);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            nodes[editingLineIndex].focusNode.requestFocus();
          });
          _updateDocument();
        });
      }
    }
  }

  void _onArrowUp() {
    if (editingLineIndex > 0) {
      setState(() {
        nodes[editingLineIndex]
            .updateText(nodes[editingLineIndex].controller.text);
        editingLineIndex--;
        nodes[editingLineIndex].controller.text =
            nodes[editingLineIndex].rawText;
        nodes[editingLineIndex].controller.selection =
            TextSelection.fromPosition(
          TextPosition(offset: nodes[editingLineIndex].controller.text.length),
        );
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[editingLineIndex].focusNode.requestFocus();
        });
      });
    }
  }

  void _onArrowDown() {
    if (editingLineIndex < nodes.length - 1) {
      setState(() {
        nodes[editingLineIndex]
            .updateText(nodes[editingLineIndex].controller.text);
        editingLineIndex++;
        nodes[editingLineIndex].controller.text =
            nodes[editingLineIndex].rawText;
        nodes[editingLineIndex].controller.selection =
            TextSelection.fromPosition(
          TextPosition(offset: nodes[editingLineIndex].controller.text.length),
        );
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[editingLineIndex].focusNode.requestFocus();
        });
      });
    }
  }

  void _onChange(String value) {
    setState(() {
      nodes[editingLineIndex].updateText(value);
      markdownWidgetList[editingLineIndex] =
          MarkdownRender().render(nodes[editingLineIndex]);
    });
  }

  void _onEditingComplete() {
    setState(() {
      final node = nodes[editingLineIndex];
      node.updateText(node.controller.text);
      markdownWidgetList[editingLineIndex] =
          MarkdownRender().render(nodes[editingLineIndex]);

      final newNode = nodes[editingLineIndex].createNewLine();

      if (editingLineIndex < nodes.length - 1) {
        nodes.insert(editingLineIndex + 1, newNode);
        markdownWidgetList.insert(
          editingLineIndex + 1,
          MarkdownRender().render(nodes[editingLineIndex + 1]),
        );
        editingLineIndex++;
      } else {
        nodes.add(newNode);
        markdownWidgetList.add(
          MarkdownRender().render(nodes[editingLineIndex + 1]),
        );
        editingLineIndex = nodes.length - 1;
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        nodes[editingLineIndex].focusNode.requestFocus();
      });
      _updateDocument();
    });
  }

  void _updateDocument() {
    fileString = document.toString();
    widget.file.writeAsStringSync(fileString);
  }
}
