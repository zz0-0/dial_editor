import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/background.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/box.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/card.dart'
    as card;
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/edge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InteractiveCanvas extends ConsumerWidget {
  const InteractiveCanvas({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nodeList = ref.watch(nodeListStateNotifierProvider);
    final boxList = nodeList.whereType<Block>().map((node) {
      return Box(node);
    }).toList();
    final cardList = nodeList.whereType<Node>().map((node) {
      return card.Card(node);
    }).toList();
    final edgeList = <Edge>[];
    return MouseRegion(
      child: InteractiveViewer(
        child: GestureDetector(
          child: SizedBox(
            width: 1000,
            height: 1000,
            child: Stack(
              children: [
                const Background(),
                ...boxList,
                ...cardList,
                ...edgeList,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
