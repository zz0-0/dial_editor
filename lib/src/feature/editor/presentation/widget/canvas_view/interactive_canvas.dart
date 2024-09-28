import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InteractiveCanvas extends ConsumerWidget {
  const InteractiveCanvas({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final nodeList = ref.watch(nodeListStateNotifierProvider);
    // final boxList = nodeList.whereType<Block>().map((node) {
    //   return Box(node);
    // }).toList();
    // final cardList = nodeList.whereType<Node>().map((node) {
    //   return card.Card(node);
    // }).toList();
    // final edgeList = <Edge>[];
    return MouseRegion(
      child: InteractiveViewer(
        clipBehavior: Clip.antiAlias,
        constrained: false,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: const SizedBox(
            width: 2 * 1000,
            height: 2 * 1000,
            child: Stack(
              children: [
                Background(),
                // ...boxList,
                // ...cardList,
                // ...edgeList,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
