import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/recursive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditingArea extends ConsumerWidget {
  const EditingArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Node> nodeList = ref.watch(nodeListStateNotifierProvider);
    final scrollController3 = ref.watch(scrollController3Provider);
    int index = 0;
    return ListView(
      controller: scrollController3,
      children: nodeList.map((node) {
        final widget = Recursive(node, index);
        if (node is Block) {
          index += node.children.length;
        } else {
          index++;
        }
        return widget;
      }).toList(),
    );
  }
}
