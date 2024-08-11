import 'package:flutter/material.dart';

extension CustomTextTheme on TextTheme {
  TextTheme customizeTextStyle(TextTheme textTheme) {
    return textTheme.copyWith(
      displayLarge: textTheme.displayLarge?.copyWith(fontSize: 64.0),
      displayMedium: textTheme.displayMedium?.copyWith(fontSize: 48.0),
      displaySmall: textTheme.displaySmall?.copyWith(fontSize: 32.0),
      headlineLarge: textTheme.headlineLarge?.copyWith(fontSize: 32.0),
      headlineMedium: textTheme.headlineMedium?.copyWith(fontSize: 28.0),
      headlineSmall: textTheme.headlineSmall?.copyWith(fontSize: 24.0),
      titleLarge: textTheme.titleLarge?.copyWith(fontSize: 22.0),
      titleMedium: textTheme.titleMedium?.copyWith(fontSize: 16.0),
      titleSmall: textTheme.titleSmall?.copyWith(fontSize: 14.0),
      bodyLarge: textTheme.bodyLarge?.copyWith(fontSize: 16.0),
      bodyMedium: textTheme.bodyMedium?.copyWith(fontSize: 14.0),
      bodySmall: textTheme.bodySmall?.copyWith(fontSize: 12.0),
      labelLarge: textTheme.labelLarge?.copyWith(fontSize: 14.0),
      labelMedium: textTheme.labelMedium?.copyWith(fontSize: 12.0),
      labelSmall: textTheme.labelSmall?.copyWith(fontSize: 11.0),
    );
  }
}
