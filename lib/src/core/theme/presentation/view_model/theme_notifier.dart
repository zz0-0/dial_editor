import 'package:dial_editor/src/core/theme/domain/model/text_theme.dart';
import 'package:flutter/material.dart';

/// A ViewModel class that extends [ChangeNotifier] to manage and notify 
/// listeners
/// about changes in the theme settings of the application.
class ThemeViewModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeData _themeData = ThemeData().copyWith(
    textTheme: ThemeData().textTheme.customizeTextStyle(ThemeData().textTheme),
  );

  /// Gets the current theme mode.
  ///
  /// Returns the current [ThemeMode] which can be either light, dark, or 
  /// system default.
  ThemeMode get themeMode => _themeMode;
  /// Returns the current [ThemeData] object.
  /// 
  /// This getter provides access to the private `_themeData` field, 
  /// which holds the theme configuration for the application.
  ThemeData get themeData => _themeData;

  /// Sets the theme to light mode.
  ///
  /// This method updates the application's theme to use light mode settings.
  void setLightMode() {
    _themeMode = ThemeMode.light;
    _themeData = ThemeData.light().copyWith(
      textTheme: ThemeData.light()
          .textTheme
          .customizeTextStyle(ThemeData.light().textTheme),
    );
    notifyListeners();
  }

  /// Sets the application theme to dark mode.
  ///
  /// This method updates the theme settings to use a dark color scheme,
  /// providing a darker background and lighter text colors suitable for
  /// low-light environments.
  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    _themeData = ThemeData.dark().copyWith(
      textTheme: ThemeData.dark()
          .textTheme
          .customizeTextStyle(ThemeData.dark().textTheme),
    );
    notifyListeners();
  }

  /// Sets the theme mode to the system's default mode.
  /// 
  /// This method adjusts the application's theme to match the current system
  /// theme, whether it is light or dark mode. It ensures that the app's 
  /// appearance
  /// is consistent with the user's system preferences.
  void setSystemMode() {
    _themeMode = ThemeMode.system;
    _themeData = ThemeData().copyWith(
      textTheme:
          ThemeData().textTheme.customizeTextStyle(ThemeData().textTheme),
    );
    notifyListeners();
  }

  /// Toggles the current theme mode between light and dark.
  ///
  /// This method switches the application's theme mode, allowing the user
  /// to alternate between light and dark themes. It updates the theme
  /// settings and notifies listeners about the change.
  void switchThemeMode() {
    if (_themeMode == ThemeMode.light) {
      setDarkMode();
    } else {
      setLightMode();
    }
    notifyListeners();
  }
}
