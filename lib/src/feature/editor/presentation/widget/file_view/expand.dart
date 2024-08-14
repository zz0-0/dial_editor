import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Expand extends ConsumerWidget {
  final Inline node;
  const Expand(this.node, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 30,
      child: Container(
        alignment: Alignment.center,
        height: node.textHeight,
        child: GestureDetector(
          onTap: () {
            ref
                .read(nodeStateProvider(node.key).notifier)
                .toggleNodeExpansion();
          },
          child: node.isBlockStart
              ? node.isExpanded
                  ? const Icon(Icons.expand_more)
                  : const Icon(Icons.chevron_right)
              : Container(),
        ),
      ),
    );
  }
}
