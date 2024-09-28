import 'package:dial_editor/src/core/provider/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Background extends ConsumerWidget {
  const Background({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final textTheme = theme.themeData.textTheme;
    return GridPaper(
      color: textTheme.headlineLarge!.color!,
      subdivisions: 2,
      child: const SizedBox.expand(),
    );
  }
}
