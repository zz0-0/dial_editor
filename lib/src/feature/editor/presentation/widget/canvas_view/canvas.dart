import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/interactive_canvas.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/menu.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/mini_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents a canvas for drawing or displaying graphical
/// content.
///
/// This widget is a consumer of the provider framework, allowing it to react
/// to changes
/// in the state and update the UI accordingly.
///
/// The `Canvas` widget is typically used in scenarios where custom drawing or
/// complex
/// graphical representations are required.
///
/// Usage:
/// ```dart
/// Canvas()
/// ```
///
/// Note: Ensure that the necessary providers are set up in the widget tree to
/// supply
/// the required state for this widget.
class Canvas extends ConsumerWidget {
  /// A widget that represents a canvas for drawing or displaying graphical
  /// content.
  ///
  /// The [Canvas] widget is a stateless widget that can be used to create a
  /// custom
  /// drawing area or to display graphical content within the application.
  ///
  /// The [key] parameter is optional and can be used to uniquely identify the
  /// widget
  /// in the widget tree.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Canvas(
  ///   key: ValueKey('canvas'),
  /// )
  /// ```
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
