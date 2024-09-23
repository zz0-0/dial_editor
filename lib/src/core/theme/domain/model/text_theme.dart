import 'package:flutter/material.dart';

/// Extension on [TextTheme] to provide custom text theme properties and 
/// methods.
///
/// This extension allows you to add custom text styles and other text-related
/// properties to the existing [TextTheme] class, enabling more flexible and
/// reusable text styling throughout your application.
extension CustomTextTheme on TextTheme {
  /// Customizes the given [TextTheme] by applying specific styles.
  ///
  /// This function takes a [TextTheme] object and modifies its properties
  /// to apply custom styles as needed.
  ///
  /// Returns the modified [TextTheme] with the applied customizations.
  TextTheme customizeTextStyle(TextTheme textTheme) {
    return textTheme.copyWith(
      displayLarge: textTheme.displayLarge?.copyWith(fontSize: 64),
      displayMedium: textTheme.displayMedium?.copyWith(fontSize: 48),
      displaySmall: textTheme.displaySmall?.copyWith(fontSize: 32),
      headlineLarge: textTheme.headlineLarge?.copyWith(fontSize: 32),
      headlineMedium: textTheme.headlineMedium?.copyWith(fontSize: 28),
      headlineSmall: textTheme.headlineSmall?.copyWith(fontSize: 24),
      titleLarge: textTheme.titleLarge?.copyWith(fontSize: 22),
      titleMedium: textTheme.titleMedium?.copyWith(fontSize: 16),
      titleSmall: textTheme.titleSmall?.copyWith(fontSize: 14),
      bodyLarge: textTheme.bodyLarge?.copyWith(fontSize: 16),
      bodyMedium: textTheme.bodyMedium?.copyWith(fontSize: 14),
      bodySmall: textTheme.bodySmall?.copyWith(fontSize: 12),
      labelLarge: textTheme.labelLarge?.copyWith(fontSize: 14),
      labelMedium: textTheme.labelMedium?.copyWith(fontSize: 12),
      labelSmall: textTheme.labelSmall?.copyWith(fontSize: 11),
    );
  }
}
