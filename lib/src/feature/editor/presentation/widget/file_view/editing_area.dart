import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/editing.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditingArea extends ConsumerWidget {
  const EditingArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Node> flatNodeList =
        ref.watch(flatNodeListStateNotifierProvider);
    final scrollController3 = ref.watch(scrollController3Provider);

    return Expanded(
      child: ListView.builder(
        controller: scrollController3,
        itemCount: flatNodeList.length,
        itemBuilder: (context, index) {
          final node = flatNodeList[index];
          final isBlock = node is Block;
          final isInline = node is Inline;

          if (isBlock || (isInline && node.isExpanded)) {
            return node.isEditing ? Editing(index) : Rendering(index);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
