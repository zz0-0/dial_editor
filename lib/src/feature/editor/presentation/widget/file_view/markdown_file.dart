import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/editing_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarkdownFile extends ConsumerStatefulWidget {
  const MarkdownFile({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MarkdownFileState();
}

class _MarkdownFileState extends ConsumerState<MarkdownFile> {
  @override
  Widget build(BuildContext context) {
    final scrollController1 = ref.watch(scrollController1Provider);
    final scrollController2 = ref.watch(scrollController2Provider);
    final scrollController3 = ref.watch(scrollController3Provider);
    var isScrolling = false;
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isScrolling && scrollInfo.depth == 0) {
          isScrolling = true;
          if (mounted) {
            setState(() {
              scrollController1.jumpTo(scrollController3.offset);
              scrollController2.jumpTo(scrollController3.offset);
            });
          }
          isScrolling = false;
        }
        return true;
      },
      child: const Row(
        children: [
          Expanded(child: EditingArea()),
        ],
      ),
    );
  }
}
