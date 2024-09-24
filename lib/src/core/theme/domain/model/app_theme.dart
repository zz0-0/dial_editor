import 'package:dial_editor/src/core/theme/domain/model/text_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.blue,
  tabBarStyle: FlexTabBarStyle.forBackground,
  textTheme: FlexThemeData.light()
      .textTheme
      .customizeTextStyle(FlexThemeData.light().textTheme),
);
final ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.blue,
  tabBarStyle: FlexTabBarStyle.forBackground,
  textTheme: FlexThemeData.dark()
      .textTheme
      .customizeTextStyle(FlexThemeData.dark().textTheme),
);
