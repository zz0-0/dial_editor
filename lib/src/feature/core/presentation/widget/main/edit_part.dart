import 'dart:io';

import 'package:dial_editor/src/feature/core/presentation/widget/main/render.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown/markdown.dart' as md;

class EditPart extends ConsumerStatefulWidget {
  final File file;
  const EditPart({super.key, required this.file});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPartState();
}

class _EditPartState extends ConsumerState<EditPart> {
  List<Text> markdownWidgetList = [];
  List<md.Node> nodes = [];
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  TextStyle currentTextStyle = const TextStyle();
  int editingLineIndex = -1;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final file = ref.watch(fileProvider);

    nodes = md.Document().parse(widget.file.readAsStringSync());
    markdownWidgetList = Render().renderList(nodes);

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
                  ? EditableText(
                      controller: controller,
                      focusNode: focusNode,
                      style: currentTextStyle,
                      cursorColor: Colors.blue,
                      backgroundCursorColor: Colors.white,
                      onEditingComplete: () {
                        setState(() {
                          markdownWidgetList[index] = Render().render(
                            md.Document().parse(controller.text)[0],
                          );
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

                          controller.text = nodes[index].textContent;
                          controller.selection = TextSelection.collapsed(
                            offset: controller.text.length,
                          );
                          currentTextStyle = markdownWidgetList[index].style ??
                              const TextStyle();
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
