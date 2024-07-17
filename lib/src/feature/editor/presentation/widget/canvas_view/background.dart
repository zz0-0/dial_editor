import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/canvas_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Background extends ConsumerWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final divisions = ref.watch(divisionsProvider);
    final subdivisions = ref.watch(subdivisionsProvider);

    return GridPaper(
      divisions: divisions,
      subdivisions: subdivisions,
      child: const SizedBox.expand(
          // width: double.infinity,
          // height: double.infinity,
          ),
    );
  }
}
