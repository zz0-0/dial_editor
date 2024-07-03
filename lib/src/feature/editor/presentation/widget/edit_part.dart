import 'dart:io';

import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/custom_editable_text.dart';
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
  List<Widget> markdownWidgetList = [];
  List<Node> nodes = [];
  final List<TextEditingController> controllers = [];
  final List<FocusNode> focusNodes = [];
  TextStyle currentTextStyle = const TextStyle();
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
    for (final node in nodes) {
      controllers.add(TextEditingController(text: node.rawText));
      focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    for (final focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  double _getTextHeight(TextStyle textStyle, String text) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.height;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: SizedBox(
            width: 30,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final textStyle = (nodes[index].style ??
                          Theme.of(context).textTheme.titleSmall)!;
                      final lineHeight =
                          _getTextHeight(textStyle, nodes[index].text);
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
                    childCount: nodes.length,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return index == editingLineIndex
                        ? _buildEditingWidget(index)
                        : _buildRenderingWidget(index);
                  },
                  childCount: markdownWidgetList.length,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditingWidget(int index) {
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace) {
          if (controllers[editingLineIndex].text.isEmpty) {
            setState(() {
              if (editingLineIndex > 0) {
                nodes.removeAt(editingLineIndex);
                controllers.removeAt(editingLineIndex);
                focusNodes.removeAt(editingLineIndex);
                markdownWidgetList.removeAt(editingLineIndex);
                editingLineIndex--;
                fileString = document.toString();
                widget.file.writeAsStringSync(fileString);
                currentTextStyle =
                    nodes[editingLineIndex].style ?? const TextStyle();
                focusNodes[editingLineIndex].requestFocus();
              }
            });
          }
        }
        return KeyEventResult.ignored;
      },
      child: CustomEditableText(
        node: nodes[index],
        controller: controllers[index],
        focusNode: focusNodes[index],
        onChanged: (value) {
          setState(() {
            nodes[editingLineIndex] =
                StringToDocumentConverter(context).convertLine(value);
            markdownWidgetList[editingLineIndex] =
                MarkdownRender().render(nodes[editingLineIndex]);
            currentTextStyle =
                nodes[editingLineIndex].style ?? const TextStyle();
          });
        },
        onEditingComplete: () {
          setState(() {
            nodes[editingLineIndex]
                .updateText(controllers[editingLineIndex].text);
            markdownWidgetList[editingLineIndex] =
                MarkdownRender().render(nodes[editingLineIndex]);

            if (editingLineIndex < nodes.length - 1) {
              nodes[editingLineIndex + 1] =
                  nodes[editingLineIndex].createNewLine();
              markdownWidgetList.add(
                MarkdownRender().render(nodes[editingLineIndex + 1]),
              );
              editingLineIndex++;
            } else {
              final newNode = nodes[editingLineIndex].createNewLine();
              nodes.add(newNode);
              markdownWidgetList.add(MarkdownRender().render(nodes.last));
              editingLineIndex = nodes.length - 1;
              controllers.add(
                TextEditingController(text: newNode.rawText),
              );
              focusNodes.add(FocusNode());
            }

            fileString = document.toString();
            widget.file.writeAsStringSync(fileString);
            currentTextStyle =
                nodes[editingLineIndex].style ?? const TextStyle();
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              focusNodes[editingLineIndex].requestFocus();
            });
          });
        },
      ),
    );
  }

  Widget _buildRenderingWidget(int index) {
    return GestureDetector(
      onTapUp: (details) {
        setState(() {
          controllers[index].clear();
          editingLineIndex = index;
          controllers[editingLineIndex].text = nodes[index].rawText;
          currentTextStyle = nodes[index].style ?? const TextStyle();
        });
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          focusNodes[editingLineIndex].requestFocus();
        });
      },
      onLongPressStart: (details) {},
      onLongPressMoveUpdate: (details) {},
      onLongPressEnd: (details) {},
      child: markdownWidgetList[index],
    );
  }
}
