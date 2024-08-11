import 'package:dial_editor/src/core/theme/domain/model/text_theme.dart';
import 'package:flutter/material.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeData _themeData = ThemeData().copyWith(
    textTheme: ThemeData().textTheme.customizeTextStyle(ThemeData().textTheme),
  );

  ThemeMode get themeMode => _themeMode;
  ThemeData get themeData => _themeData;

  void setLightMode() {
    _themeMode = ThemeMode.light;
    _themeData = ThemeData.light().copyWith(
      textTheme: ThemeData.light()
          .textTheme
          .customizeTextStyle(ThemeData.light().textTheme),
    );
    notifyListeners();
  }

  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    _themeData = ThemeData.dark().copyWith(
      textTheme: ThemeData.dark()
          .textTheme
          .customizeTextStyle(ThemeData.light().textTheme),
    );
    notifyListeners();
  }

  void setSystemMode() {
    _themeMode = ThemeMode.system;
    _themeData = ThemeData().copyWith(
      textTheme:
          ThemeData().textTheme.customizeTextStyle(ThemeData().textTheme),
    );
    notifyListeners();
  }

  void switchThemeMode() {
    if (_themeMode == ThemeMode.light) {
      setDarkMode();
    } else {
      setLightMode();
    }
    notifyListeners();
  }
}
