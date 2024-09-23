import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that expands its child widget within the file view.
///
/// This widget is a consumer widget that listens to changes in the provider
/// and rebuilds accordingly. It is used to manage the expanded state of a
/// file view in the editor.
///
/// Usage:
/// ```dart
/// Expand(
///   // child widget here
/// )
/// ```
///
/// The `Expand` widget is typically used in scenarios where you need to
/// dynamically expand or collapse sections of the file view based on
/// user interaction or other state changes.
class Expand extends ConsumerWidget {
  /// A widget that expands the given node.
  ///
  /// This widget takes a node and expands it within the UI. It is typically 
  /// used
  /// to display additional details or content related to the node.
  ///
  /// The [node] parameter is the node to be expanded.
  ///
  /// Example usage:
  /// ```dart
  /// Expand(myNode);
  /// ```
  ///
  /// See also:
  ///  * [Node], which is the type of the node being expanded.
  const Expand(this.node, {super.key});

  /// A final variable that holds an instance of the `Inline` class.
  /// This variable represents a node in the file view widget.
  final Inline node;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 30,
      child: Container(
        alignment: Alignment.center,
        height: node.textHeight,
        child: GestureDetector(
          onTap: () {
            ref
                .read(nodeStateProvider(node.key).notifier)
                .toggleNodeExpansion();
          },
          child: node.isBlockStart
              ? node.isExpanded
                  ? const Icon(Icons.expand_more)
                  : const Icon(Icons.chevron_right)
              : Container(),
        ),
      ),
    );
  }
}
