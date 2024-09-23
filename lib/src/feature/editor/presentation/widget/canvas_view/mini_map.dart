import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that provides a mini map view of the canvas.
///
/// This widget is a consumer of the state, allowing it to react to changes
/// and update the mini map accordingly. It is typically used to give users
/// an overview of the entire canvas, enabling easier navigation and
/// orientation within the editor.
///
/// The `MiniMap` widget is part of the presentation layer of the editor
/// feature and is located in the `canvas_view` directory.
class MiniMap extends ConsumerWidget {
  /// A widget that represents a mini map view within the canvas editor.
  ///
  /// This widget is used to provide an overview of the entire canvas, allowing
  /// users to quickly navigate and locate different parts of the canvas.
  ///
  /// The [MiniMap] widget is a stateless widget and requires a key to be passed
  /// to its constructor.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// MiniMap(key: ValueKey('miniMap'));
  /// ```
  const MiniMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
