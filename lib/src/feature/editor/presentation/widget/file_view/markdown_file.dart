import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/editing_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents a Markdown file view.
/// 
/// This widget is a `ConsumerStatefulWidget` which means it can consume
/// providers and maintain state. It is used to display and interact with
/// Markdown files within the application.
/// 
/// The `MarkdownFile` widget is part of the `file_view` feature in the
/// `editor` presentation layer.
class MarkdownFile extends ConsumerStatefulWidget {
  /// A widget that represents a Markdown file.
  /// 
  /// This widget is used to display the contents of a Markdown file within the
  /// application. It takes an optional key parameter.
  /// 
  /// Example usage:
  /// 
  /// ```dart
  /// MarkdownFile(key: ValueKey('markdown_file'));
  /// ```
  /// 
  /// {@category Widgets}
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
          // TableOfContent(),
        ],
      ),
    );
  }
}
