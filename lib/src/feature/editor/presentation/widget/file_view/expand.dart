import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Expand extends ConsumerWidget {
  const Expand({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Node> flatNodeList =
        ref.watch(flatNodeListStateNotifierProvider);
    final flatNodeListStateNotifier =
        ref.read(flatNodeListStateNotifierProvider.notifier);
    final scrollController2 = ref.watch(scrollController2Provider);

    return SizedBox(
      width: 30,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          controller: scrollController2,
          itemCount: flatNodeListStateNotifier.getListLength(),
          itemBuilder: (context, index) {
            final node = flatNodeList[index];
            final isBlock = node is Block;
            final isInline = node is Inline;

            if (isBlock || (isInline && node.isExpanded)) {
              return Row(
                children: [
                  const Spacer(),
                  Container(
                    alignment: Alignment.center,
                    height: node.textHeight,
                    child: GestureDetector(
                      onTap: () {
                        flatNodeListStateNotifier.toggleNodeExpansion(index);
                      },
                      child: isBlock
                          ? flatNodeListStateNotifier
                                  .getNodeByIndex(index)
                                  .isExpanded
                              ? const Icon(Icons.expand_more)
                              : const Icon(Icons.chevron_right)
                          : Container(),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
