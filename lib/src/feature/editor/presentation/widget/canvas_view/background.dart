import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents the background of the canvas view in the editor.
///
/// This widget is a [ConsumerWidget] which means it listens to changes in the
/// provider and rebuilds accordingly. It is used to render the background
/// of the canvas where the editing takes place.
///
/// The [Background] widget is part of the presentation layer of the editor
/// feature.
class Background extends ConsumerWidget {
  /// Constructs a [Background] widget with the given [key].
  const Background({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
