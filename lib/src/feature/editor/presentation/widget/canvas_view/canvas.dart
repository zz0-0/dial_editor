import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/interactive_canvas.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/menu.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/mini_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Canvas extends ConsumerWidget {
  const Canvas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Listener(
      child: LayoutBuilder(
        builder: (context, constraits) {
          return const Stack(
            children: [
              InteractiveCanvas(),
              MiniMap(),
              Menu(),
            ],
          );
        },
      ),
    );
  }
}
