import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CanvasView extends ConsumerStatefulWidget {
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
