import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that handles the rendering of the file view in the editor feature.
///
/// This widget is a [ConsumerWidget], which means it listens to changes in the
/// provider and rebuilds accordingly. It is used to display and manage the
/// visual representation of files within the editor.
///
/// The [Rendering] widget is part of the presentation layer of the editor
/// feature and is responsible for rendering the file view based on the
/// provided data and state.
class Rendering extends ConsumerWidget {
  /// A widget that renders a node in the editor.
  ///
  /// The [Rendering] widget takes a [node] as a required parameter and
  /// optionally accepts a [key].
  ///
  /// Example usage:
  /// ```dart
  /// Rendering(node)
  /// ```
  ///
  /// - [node]: The node to be rendered.
  /// - [key]: An optional key for the widget.
  const Rendering(this.node, {super.key});

  /// A final variable representing an inline node in the rendering process.
  ///
  /// This variable is used to store an instance of the `Inline` class, which
  /// represents an inline element in the document structure.
  final Inline node;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final renderAdapter = ref.read(renderAdapterProvider);
    final instruction = node.render();
    final w = renderAdapter.adapt(node, instruction, context);
    return GestureDetector(
      onTapUp: (details) {
        ref
            .read(nodeStateProvider(node.key).notifier)
            .setNodeToEditingModeOnTap(node, details);
      },
      child: w,
    );
  }
}
