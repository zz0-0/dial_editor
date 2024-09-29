import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Background extends ConsumerWidget {
  const Background({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(themeProvider);
    // final textTheme = theme.themeData.textTheme;
    return const GridPaper(
      // color: textTheme.headlineLarge!.color!,
      color: Colors.white,
      subdivisions: 2,
      child: SizedBox.expand(),
    );
  }
}
