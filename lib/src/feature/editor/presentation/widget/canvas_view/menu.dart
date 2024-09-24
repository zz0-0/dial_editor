import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Menu extends ConsumerWidget {
  const Menu({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          FloatingActionButton(
            onPressed: () => _createGroupWidget(ref),
            mini: true,
            tooltip: 'Add Group',
            child: const Icon(Icons.add_home_outlined),
          ),
          FloatingActionButton(
            onPressed: () => _createInfoCardWidget(ref),
            mini: true,
            tooltip: 'Add Card',
            child: const Icon(Icons.add_box_outlined),
          ),
          FloatingActionButton(
            onPressed: _resetCanvasZoomLevel,
            mini: true,
            tooltip: 'Reset Zoom',
            child: const Icon(Icons.restore_page_outlined),
          ),
          FloatingActionButton(
            onPressed: () => _zoomIn(ref),
            mini: true,
            tooltip: 'Zoom in',
            child: const Icon(Icons.arrow_circle_up),
          ),
          FloatingActionButton(
            onPressed: () => _zoomOut(ref),
            mini: true,
            tooltip: 'Zoom out',
            child: const Icon(Icons.arrow_circle_down),
          ),
        ],
      ),
    );
  }

  void _createGroupWidget(WidgetRef ref) {}

  void _createInfoCardWidget(WidgetRef ref) {}

  void _resetCanvasZoomLevel() {}

  void _zoomIn(WidgetRef ref) {}

  void _zoomOut(WidgetRef ref) {}
}
