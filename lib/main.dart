import 'package:dial_editor/src/core/provider/router/router_provider.dart';
import 'package:dial_editor/src/core/provider/theme/theme_provider.dart';
import 'package:dial_editor/src/core/theme/domain/model/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// A [ConsumerWidget] that represents the main application widget.
///
/// This widget is the entry point of the application and is responsible for
/// setting up the necessary providers and rendering the initial UI.
///
/// It listens to changes in the provided state and rebuilds accordingly.
class MyApp extends ConsumerWidget {
  /// A constant constructor for the `MyApp` class.
  ///
  /// The `super.key` parameter is passed to the superclass constructor,
  /// which is typically used to manage the widget's key.
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
