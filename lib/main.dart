import 'package:dial_editor/main_provider.dart';
import 'package:dial_editor/src/core/router.dart';
import 'package:dial_editor/src/core/theme/app_theme.dart';
import 'package:dial_editor/src/core/theme/theme_provider.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/desktop_editor.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/mobile_editor.dart';
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
    final isDesktop = ref.read(isDesktopProvider);
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
