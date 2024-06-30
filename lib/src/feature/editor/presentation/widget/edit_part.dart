import 'dart:io';

import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/document_codec.dart';
import 'package:dial_editor/src/feature/editor/util/markdown_render.dart';
import 'package:dial_editor/src/feature/editor/util/string_to_document_converter.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
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
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
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
            child: ListView.builder(
              itemCount: markdownWidgetList.length,
              itemBuilder: (context, index) {
                final textStyle = (nodes[index].style ??
                    Theme.of(context).textTheme.bodyMedium)!;
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
        ),
        Expanded(
          child: SelectionArea(
            child: ListView.builder(
              itemCount: markdownWidgetList.length,
              itemBuilder: (context, index) {
                return index == editingLineIndex
                    ? EditableText(
                        controller: controller,
                        focusNode: focusNode,
                        style: currentTextStyle,
                        cursorColor: Colors.blue,
                        backgroundCursorColor: Colors.white,
                        // decoration: const InputDecoration(
                        //   border: InputBorder.none,
                        //   fillColor: Colors.transparent,
                        // ),
                        onChanged: (value) {
                          setState(() {
                            nodes[editingLineIndex] =
                                StringToDocumentConverter(context)
                                    .convertLine(value);
                            markdownWidgetList[editingLineIndex] =
                                MarkdownRender()
                                    .render(nodes[editingLineIndex]);
                            currentTextStyle = nodes[editingLineIndex].style ??
                                const TextStyle();
                          });
                        },

                        onEditingComplete: () {
                          setState(() {
                            nodes[editingLineIndex].updateText(controller.text);
                            markdownWidgetList[editingLineIndex] =
                                MarkdownRender()
                                    .render(nodes[editingLineIndex]);
                            fileString = document.toString();
                            widget.file.writeAsStringSync(fileString);
                            editingLineIndex = -1;
                            controller.clear();
                            currentTextStyle = const TextStyle();
                          });
                        },
                      )
                    : GestureDetector(
                        onTapUp: (details) {
                          setState(() {
                            controller.clear();
                            editingLineIndex = index;
                            controller.text = nodes[index].rawText;
                            controller.selection = TextSelection.collapsed(
                              offset: controller.text.length,
                            );
                            currentTextStyle =
                                nodes[index].style ?? const TextStyle();
                          });
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            focusNode.requestFocus();
                          });
                        },
                        child: markdownWidgetList[index],
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}
