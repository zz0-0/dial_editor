import 'dart:io';

import 'package:dial_editor/src/core/provider/theme/theme_provider.dart';
import 'package:dial_editor/src/core/router/router.dart';
import 'package:dial_editor/src/core/theme/domain/model/app_theme.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/desktop_ui.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/mobile_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider that determines if the current platform is a desktop.
///
/// This provider can be used to conditionally render widgets or execute
/// platform-specific logic based on whether the application is running
/// on a desktop platform.
final isDesktopProvider = Provider(
  (ref) => Platform.isWindows || Platform.isMacOS || Platform.isLinux,
);

/// A provider that manages the UI state of the application.
///
/// This provider is responsible for handling the state related to the user
/// interface.
/// It uses the Riverpod package to manage state and provide it to the rest of
/// the application.
///
/// The provider is defined using the `Provider` class from Riverpod, and it
/// takes a
/// reference (`ref`) as a parameter, which can be used to read other providers
/// or
/// perform other state management tasks.
///
/// Example usage:
///
/// ```dart
/// final uiState = ref.watch(uiProvider);
/// ```
///
/// This will allow you to access the current UI state managed by this provider.
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
