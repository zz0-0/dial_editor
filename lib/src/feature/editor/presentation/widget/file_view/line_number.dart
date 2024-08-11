import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LineNumber extends ConsumerWidget {
  const LineNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Node> flatNodeList =
        ref.watch(flatNodeListStateNotifierProvider);
    final flatNodeListStateNotifier =
        ref.read(flatNodeListStateNotifierProvider.notifier);
    final scrollController1 = ref.watch(scrollController1Provider);

    return SizedBox(
      width: 30,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          controller: scrollController1,
          itemCount: flatNodeListStateNotifier.getListLength(),
          itemBuilder: (context, index) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              flatNodeListStateNotifier.updateNodeHeight(index, context);
            });
            final node = flatNodeList[index];
            final isBlock = node is Block;
            final isInline = node is Inline;

            if (isBlock || (isInline && node.isExpanded)) {
              return Row(
                children: [
                  const Spacer(),
                  Container(
                    alignment: Alignment.centerRight,
                    height: flatNodeListStateNotifier
                        .getNodeByIndex(index)
                        .textHeight,
                    child: Text(
                      "${index + 1}",
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
