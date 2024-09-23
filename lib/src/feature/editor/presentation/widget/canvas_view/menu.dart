import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents a menu in the canvas view of the editor feature.
///
/// This widget is a consumer of the provider framework, allowing it to react
/// to changes in the state and update accordingly.
///
/// The `Menu` widget is part of the presentation layer of the editor feature,
/// and it is responsible for displaying and managing the menu options available
/// to the user within the canvas view.
///
/// {@category Widget}
/// {@subCategory Editor}
class Menu extends ConsumerWidget {
  /// A widget that represents a menu in the canvas view of the editor.
  ///
  /// This widget is used to display a menu with various options or actions
  /// that can be performed within the canvas view.
  ///
  /// The [Menu] widget is a stateless widget and requires a key to be passed
  /// to its constructor.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Menu(
  ///   key: ValueKey('menu'),
  /// )
  /// ```
  const Menu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
