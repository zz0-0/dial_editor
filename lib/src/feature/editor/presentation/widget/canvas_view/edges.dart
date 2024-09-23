import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents the edges of a canvas view in the editor feature.
///
/// This widget is a consumer of the state provided by Riverpod, allowing it to
/// reactively rebuild when the relevant state changes.
///
/// The `Edges` widget is used to define and manage the edges of the canvas,
/// providing visual boundaries or interactive elements as needed.
///
/// It extends `ConsumerWidget` to leverage Riverpod's state management
/// capabilities.
class Edges extends ConsumerWidget {
  /// Constructs an [Edges] widget with the given [key].
  const Edges({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
