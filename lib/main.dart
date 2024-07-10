import 'dart:io';
import 'package:dial_editor/src/feature/core/data/router.dart';
import 'package:dial_editor/src/feature/core/presentation/screen/desktop_layout/desktop_editor.dart';
import 'package:dial_editor/src/feature/core/presentation/screen/mobile_layout/mobile_editor.dart';
import 'package:dial_editor/src/feature/core/presentation/theme/app_theme.dart';
import 'package:dial_editor/src/feature/core/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider);
    final isDesktop =
        Platform.isWindows || Platform.isMacOS || Platform.isLinux;
    final app = MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeNotifier.themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeNotifier.themeMode,
      home: isDesktop ? DesktopEditor(child: app) : MobileEditor(child: app),
    );
  }
}
