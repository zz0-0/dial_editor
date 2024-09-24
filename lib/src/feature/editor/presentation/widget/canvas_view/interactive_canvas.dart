import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/background.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/boxes.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/edges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InteractiveCanvas extends ConsumerWidget {
  const InteractiveCanvas({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MouseRegion(
      child: InteractiveViewer(
        child: GestureDetector(
          child: const SizedBox(
            width: 1000,
            height: 1000,
            child: Stack(
              children: [
                Background(),
                Boxes(),
                Edges(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
