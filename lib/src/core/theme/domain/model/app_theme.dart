import 'package:dial_editor/src/core/theme/domain/model/text_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// A predefined light theme for the application using FlexThemeData.
///
/// This theme can be used to provide a consistent light appearance
/// across the app. It leverages the FlexThemeData package to ensure
/// a cohesive and customizable design.
final ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.blue,
  tabBarStyle: FlexTabBarStyle.forBackground,
  textTheme: FlexThemeData.light()
      .textTheme
      .customizeTextStyle(FlexThemeData.light().textTheme),
);

/// A predefined dark theme for the application using FlexThemeData.
///
/// This theme can be used to provide a consistent dark appearance
/// throughout the app, leveraging the FlexColorScheme package for
/// enhanced theming capabilities.
final ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.blue,
  tabBarStyle: FlexTabBarStyle.forBackground,
  textTheme: FlexThemeData.dark()
      .textTheme
      .customizeTextStyle(FlexThemeData.dark().textTheme),
);
