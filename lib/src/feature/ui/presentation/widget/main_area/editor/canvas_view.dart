import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents the main canvas area in the editor.
///
/// This widget is a `ConsumerStatefulWidget` which means it can listen to
/// changes in the state provided by Riverpod and rebuild accordingly.
///
/// The `CanvasView` is responsible for rendering the main editing area
/// where users can interact with and manipulate their content.
///
/// This widget is part of the `main_area` feature in the editor.
class CanvasView extends ConsumerStatefulWidget {
  /// A widget that represents the main canvas view in the editor.
  ///
  /// This widget is used to display and interact with the main editing area
  /// of the application.
  ///
  const CanvasView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CanvasViewState();
}

class _CanvasViewState extends ConsumerState<CanvasView> {
  @override
  Widget build(BuildContext context) {
    return const Canvas();
  }
}
