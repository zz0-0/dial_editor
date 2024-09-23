import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents a collection of boxes within the canvas view.
///
/// This widget is a consumer of the provider framework, allowing it to
/// reactively rebuild when the state changes.
///
/// The `Boxes` widget is typically used within the editor feature to
/// display and manage multiple box elements on the canvas.
///
/// {@category Widgets}
/// {@subCategory Editor}
class Boxes extends ConsumerWidget {
  /// A widget that represents a collection of boxes.
  ///
  /// This widget is used within the canvas view of the editor feature.
  ///
  /// The [Boxes] widget is stateless and requires a key to be passed to its
  /// constructor.
  const Boxes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
