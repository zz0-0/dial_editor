import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/editing.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/expand.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/line_number.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Recursive extends ConsumerWidget {
  final Node node;
  final int index;
  const Recursive(
    this.node,
    this.index, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = index;
    if (node is Block) {
      ref
          .read(nodeListStateNotifierProvider.notifier)
          .insertBlockNodeIntoMap(node.key, node as Block);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (node as Block).children.map((child) {
          final widget = Recursive(child, currentIndex);
          if (child is Block) {
            currentIndex += child.children.length;
          } else {
            currentIndex++;
          }
          return widget;
        }).toList(),
      );
    } else if (node is Inline) {
      final inlineNode = node as Inline;
      final List<Inline?> updatedNode =
          ref.watch(nodeStateProvider(inlineNode.key));
      if (updatedNode.isEmpty) {
        updatedNode.add(inlineNode);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(nodeStateProvider(node.key).notifier).initialize(inlineNode);
          ref
              .read(nodeListStateNotifierProvider.notifier)
              .insertNodeIntoFlatNodeList(inlineNode);
        });
      }
      return _buildNodeContent(ref, updatedNode[0]!, currentIndex);
    }
    return Container();
  }

  bool _shouldExpanded(WidgetRef ref, Inline inline) {
    if (ref.read(toggleNodeExpansionKeyProvider) == null) {
      if (inline.isBlockStart || (!inline.isBlockStart && inline.isExpanded)) {
        return true;
      } else {
        return false;
      }
    } else {
      if (inline.isBlockStart &&
          inline.key == ref.read(toggleNodeExpansionKeyProvider)) {
        return true;
      } else {
        return false;
      }
    }
  }

  Widget _buildNodeContent(WidgetRef ref, Inline inline, int currentIndex) {
    return _shouldExpanded(ref, inline)
        ? Row(
            children: [
              LineNumber(inline, currentIndex),
              Expand(inline),
              Expanded(
                child: inline.isEditing ? Editing(inline) : Rendering(inline),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
