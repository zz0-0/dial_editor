import 'package:dial_editor/src/core/theme/presentation/view_model/theme_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider that manages the theme state of the application.
/// 
/// This provider uses `ChangeNotifierProvider` to create an instance of 
/// `ChangeNotifier` which listens to changes in the theme settings and 
/// notifies its listeners accordingly.
/// 
/// Usage:
/// ```dart
/// final theme = context.read(themeProvider);
/// ```
/// 
/// The `themeProvider` can be used to access and modify the theme settings 
/// throughout the application.
final themeProvider = ChangeNotifierProvider((ref) {
  return ThemeViewModel();
});
