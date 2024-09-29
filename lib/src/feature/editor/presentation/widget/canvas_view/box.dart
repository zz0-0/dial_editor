import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/card.dart'
    as card;
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/editing.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/rendering.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Box extends ConsumerWidget {
  const Box(this.node, {super.key});
  final Node node;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Draggable(
      feedback: Container(),
      onDragUpdate: (details) {},
      onDragEnd: (details) {},
      childWhenDragging: Container(),
      child: DottedBorder(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ...(node as Block).children.map(
                (e) {
                  if (e is Block) {
                    return card.Card(e);
                  } else if (e is Inline) {
                    return _buildInlineContent(e);
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInlineContent(Inline inline) {
    if (inline.isEditing) {
      return Editing(inline);
    } else {
      return Rendering(inline);
    }
  }
}
