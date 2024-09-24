import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Rendering extends ConsumerWidget {
  const Rendering(this.node, {super.key});
  final Inline node;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final renderAdapter = ref.read(renderAdapterProvider);
    final instruction = node.render();
    final w = renderAdapter.adapt(node, instruction, context);
    return GestureDetector(
      onTapUp: (details) {
        ref
            .read(nodeStateProvider(node.key).notifier)
            .setNodeToEditingModeOnTap(node, details);
      },
      child: w,
    );
  }
}
