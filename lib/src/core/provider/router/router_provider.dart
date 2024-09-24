import 'dart:io';
import 'package:dial_editor/src/core/provider/theme/theme_provider.dart';
import 'package:dial_editor/src/core/router/router.dart';
import 'package:dial_editor/src/core/theme/domain/model/app_theme.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/desktop_ui.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/mobile_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDesktopProvider = Provider(
  (ref) => Platform.isWindows || Platform.isMacOS || Platform.isLinux,
);
final uiProvider = Provider((ref) {
  final theme = ref.watch(themeProvider);
  final app = MaterialApp.router(
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: theme.themeMode,
    debugShowCheckedModeBanner: false,
    routerConfig: router,
  );
  return ref.watch(isDesktopProvider)
      ? DesktopUI(child: app)
      : MobileUI(child: app);
});
