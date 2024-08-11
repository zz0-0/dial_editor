import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Rendering extends ConsumerWidget {
  final int index;
  const Rendering(this.index, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flatNodeListStateNotifier =
        ref.watch(flatNodeListStateNotifierProvider.notifier);
    final widgetListStateNotifier =
        ref.watch(widgetListStateNotifierProvider.notifier);

    return GestureDetector(
      onTapUp: (details) {
        flatNodeListStateNotifier.setNodeToEditingModeByIndex(index, details);
      },
      child: widgetListStateNotifier.getWidgetByIndex(index),
    );
  }
}
