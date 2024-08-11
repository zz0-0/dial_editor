import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Expand extends ConsumerWidget {
  const Expand({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flatNodeListStateNotifier =
        ref.read(flatNodeListStateNotifierProvider.notifier);
    return SizedBox(
      width: 30,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          itemCount: flatNodeListStateNotifier.getListLength(),
          itemBuilder: (context, index) {
            return Row(
              children: [
                const Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  height: flatNodeListStateNotifier
                      .getNodeByIndex(index)
                      .textHeight,
                  child:
                      flatNodeListStateNotifier.getNodeByIndex(index) is Block
                          ? isExpanded(
                              ref,
                              flatNodeListStateNotifier.getNodeByIndex(index),
                            )
                              ? const Icon(Icons.expand_more)
                              : const Icon(Icons.chevron_right)
                          : Container(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  bool isExpanded(WidgetRef ref, Node node) {
    return ref.watch(fileNodeExpandedProvider(node.key));
  }
}
