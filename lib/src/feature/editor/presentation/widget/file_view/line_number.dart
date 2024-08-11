import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LineNumber extends ConsumerWidget {
  const LineNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(flatNodeListStateNotifierProvider);
    final flatNodeListStateNotifier =
        ref.read(flatNodeListStateNotifierProvider.notifier);
    final scrollController1 = ref.watch(scrollController1Provider);

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: SizedBox(
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
            },
          ),
        ),
      ),
    );
  }
}
