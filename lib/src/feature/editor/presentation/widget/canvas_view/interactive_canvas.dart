import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/background.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/boxes.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/edges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that provides an interactive canvas for user interactions.
///
/// This widget is a consumer of the provider pattern, allowing it to react
/// to changes in the state provided by the provider.
///
/// The `InteractiveCanvas` can be used to create a drawing area, a
/// drag-and-drop
/// interface, or any other interactive UI component that requires a canvas.
///
/// Usage:
/// ```dart
/// InteractiveCanvas()
/// ```
///
/// Note: Ensure that the necessary providers are set up in the widget tree
/// to supply the required state for this widget.
class InteractiveCanvas extends ConsumerWidget {
  /// A widget that represents an interactive canvas.
  ///
  /// This widget is used to create a canvas that can handle user interactions.
  ///
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
