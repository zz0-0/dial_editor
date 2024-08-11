import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
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
    final scrollController2 = ref.watch(scrollController2Provider);

    return Expanded(
      child: ListView.builder(
        controller: scrollController2,
        itemCount: flatNodeList.length,
        itemBuilder: (context, index) {
          return flatNodeList[index].isEditing
              ? Editing(index)
              : Rendering(index);
        },
      ),
    );
  }
}
