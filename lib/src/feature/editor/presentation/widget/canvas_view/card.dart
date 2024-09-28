import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/editing.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Card extends ConsumerWidget {
  const Card(this.node, {super.key});
  final Node node;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: (node as Block).children.map((e) {
        if (e is Block) {
          // return card.Card(e);
        } else if (e is Inline) {
          return _buildInlineContent(e);
        }
        return Container();
      }).toList(),
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
