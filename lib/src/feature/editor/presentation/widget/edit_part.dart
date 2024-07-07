import 'dart:io';

import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/document_codec.dart';
import 'package:dial_editor/src/feature/editor/util/markdown_render.dart';
import 'package:dial_editor/src/feature/editor/util/string_to_document_converter.dart';
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
  void dispose() {
    super.dispose();
    for (final node in nodes) {
      node.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            _buildLineNumber(),
            _buildEditingArea(),
          ],
        ),
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
                Container(
                  alignment: Alignment.centerRight,
                  height: lineHeight,
                  child: Text(
                    "${index + 1}",
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
          return nodes[index].isEditing
              ? _buildEditingWidget(index)
              : _buildRenderingWidget(index);
        },
      ),
    );
  }

  Widget _buildEditingWidget(int index) {
    return Focus(
      onFocusChange: (hasFocus) {},
      onKeyEvent: (node, event) => _onKeyEvent(event, index),
      child: GestureDetector(
        child: TextField(
          controller: nodes[index].controller,
          focusNode: nodes[index].focusNode,
          cursorColor: Colors.blue,
          style: nodes[index].style,
          decoration: const InputDecoration.collapsed(
            fillColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            hintText: '',
          ),
          onChanged: (value) {
            _onChange(index, value);
          },
          onEditingComplete: () {
            _onEditingComplete(index);
          },
          onTap: () {
            for (final node in nodes) {
              node.controller.selection =
                  const TextSelection.collapsed(offset: 0);
            }
          },
        ),
      ),
    );
  }

  KeyEventResult _onKeyEvent(KeyEvent event, int index) {
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      _onDelete(index);
    }

    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _onArrowUp(index);
    }

    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _onArrowDown(index);
    }

    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _onArrowLeft(index, HardwareKeyboard.instance.isShiftPressed);
    }

    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowRight) {
      _onArrowRight(index, HardwareKeyboard.instance.isShiftPressed);
    }

    return KeyEventResult.ignored;
  }

  Widget _buildRenderingWidget(int index) {
    return GestureDetector(
      onTapUp: (details) {
        setState(() {
          for (int i = 0; i < nodes.length; i++) {
            nodes[i].isEditing = false;
          }
          nodes[index].isEditing = true;
          nodes[index].controller.clear();
          nodes[index].controller.text = nodes[index].rawText;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            nodes[index].focusNode.requestFocus();
          });
        });
      },
      child: markdownWidgetList[index],
    );
  }

  void _onDelete(int index) {
    if (nodes[index].text.isEmpty && nodes[index].controller.text.isEmpty) {
      if (index > 0) {
        setState(() {
          nodes.removeAt(index);
          markdownWidgetList.removeAt(index);

          nodes[index - 1].isEditing = true;
          fileString = document.toString();
          widget.file.writeAsStringSync(fileString);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            nodes[index - 1].focusNode.requestFocus();
          });
          _updateDocument();
        });
      }
    }
  }

  void _onArrowUp(int index) {
    if (index > 0) {
      setState(() {
        nodes[index].isEditing = false;
        nodes[index - 1].isEditing = true;
        nodes[index].controller.text = nodes[index].rawText;
        nodes[index].controller.selection = TextSelection.fromPosition(
          TextPosition(offset: nodes[index].controller.text.length),
        );
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index - 1].focusNode.requestFocus();
        });
      });
    }
  }

  void _onArrowDown(int index) {
    if (index < nodes.length - 1) {
      setState(() {
        nodes[index].isEditing = false;
        nodes[index + 1].isEditing = true;
        nodes[index].controller.text = nodes[index].rawText;
        nodes[index].controller.selection = TextSelection.fromPosition(
          TextPosition(offset: nodes[index].controller.text.length),
        );
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index + 1].focusNode.requestFocus();
        });
      });
    }
  }

  void _onArrowLeft(int index, bool isShiftPressed) {
    _handleArrowKey(index, true, isShiftPressed);
  }

  void _onArrowRight(int index, bool isShiftPressed) {
    _handleArrowKey(index, false, isShiftPressed);
  }

  void _onChange(int index, String value) {
    final currentSelection = nodes[index].controller.selection;
    setState(() {
      nodes[index] = StringToDocumentConverter(context).convertLine(value);
      markdownWidgetList[index] = MarkdownRender().render(nodes[index]);
      nodes[index].isEditing = true;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        nodes[index].controller.selection = currentSelection;
        nodes[index].focusNode.requestFocus();
      });
      _updateDocument();
    });
  }

  void _onEditingComplete(int index) {
    setState(() {
      markdownWidgetList[index] = MarkdownRender().render(nodes[index]);

      final newNode = nodes[index].createNewLine();

      if (index < nodes.length - 1) {
        nodes.insert(index + 1, newNode);
        markdownWidgetList.insert(
          index + 1,
          MarkdownRender().render(nodes[index + 1]),
        );

        nodes[index + 1].isEditing = true;
      } else {
        nodes.add(newNode);
        markdownWidgetList.add(
          MarkdownRender().render(nodes[index + 1]),
        );
        nodes[nodes.length - 1].isEditing = true;
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        nodes[index + 1].focusNode.requestFocus();
      });
      _updateDocument();
    });
  }

  void _updateDocument() {
    fileString = document.toString();
    widget.file.writeAsStringSync(fileString);
  }

  void _handleArrowKey(int index, bool isLeft, bool isShiftPressed) {
    if (isShiftPressed) {
      _handleSelectionExtension(index, isLeft);
    } else {
      _moveCursor(index, isLeft);
    }
  }

  void _handleSelectionExtension(int index, bool isLeft) {
    final currentNode = nodes[index];
    final selection = currentNode.controller.selection;

    if (isLeft && selection.extentOffset == 0 && index > 0) {
      setState(() {
        nodes[index - 1].isEditing = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index - 1].focusNode.requestFocus();
          nodes[index].controller.selection = selection;
        });
      });
    } else if (!isLeft &&
        selection.extentOffset == currentNode.rawText.length &&
        index < nodes.length - 1) {
      setState(() {
        nodes[index + 1].isEditing = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index + 1].focusNode.requestFocus();
          nodes[index].controller.selection = selection;
        });
      });
    }
  }

  void _moveCursor(int index, bool isLeft) {
    final currentNode = nodes[index];
    final selection = currentNode.controller.selection;

    setState(() {
      if (isLeft && selection.baseOffset == 0 && index > 0) {
        nodes[index - 1].isEditing = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index - 1].focusNode.requestFocus();
        });
      } else if (!isLeft &&
          selection.baseOffset == currentNode.rawText.length &&
          index < nodes.length - 1) {
        nodes[index + 1].isEditing = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index + 1].focusNode.requestFocus();
        });
      }
    });
  }
}
