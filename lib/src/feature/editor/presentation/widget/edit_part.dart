import 'dart:io';

import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/document_codec.dart';
import 'package:dial_editor/src/feature/editor/util/markdown_render.dart';
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
    print(markdownWidgetList);
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: markdownWidgetList.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            SizedBox(
              width: 30,
              child: Text("${index + 1}"),
            ),
            Expanded(
              child: index == editingLineIndex
                  ? TextField(
                      controller: controller,
                      focusNode: focusNode,
                      style: currentTextStyle,
                      cursorColor: Colors.blue,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.transparent,
                      ),
                      onEditingComplete: () {
                        setState(() {
                          nodes[editingLineIndex].updateText(controller.text);
                          markdownWidgetList[editingLineIndex] =
                              MarkdownRender().render(nodes[editingLineIndex]);
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
                          editingLineIndex = index;
                          controller.text = nodes[index].rawText;
                          controller.selection = TextSelection.collapsed(
                            offset: controller.text.length,
                          );
                          currentTextStyle = nodes[index].style!;
                        });
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          focusNode.requestFocus();
                        });
                      },
                      child: markdownWidgetList[index],
                    ),
            ),
          ],
        );
      },
    );
  }
}
