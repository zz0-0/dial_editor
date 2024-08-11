import 'package:dial_editor/src/core/provider/router/router_provider.dart';
import 'package:dial_editor/src/core/provider/theme/theme_provider.dart';
import 'package:dial_editor/src/core/theme/domain/model/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final ui = ref.watch(uiProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: theme.themeMode,
      home: ui,
    );
  }
}
