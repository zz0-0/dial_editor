import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/editing.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Box extends ConsumerWidget {
  const Box(this.node, {super.key});
  final Node node;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (node is Block) {
      return Column(
        children: (node as Block).children.map((child) {
          return Box(child);
        }).toList(),
      );
    } else if (node is Inline) {
      return _buildInlineContent(node as Inline);
    }
    return Container();
  }

  Widget _buildInlineContent(Inline inline) {
    if (inline.isEditing) {
      return Editing(inline);
    } else {
      return Rendering(inline);
    }
  }
}
