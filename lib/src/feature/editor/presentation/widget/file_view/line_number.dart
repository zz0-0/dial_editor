import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that displays line numbers for a text editor.
///
/// This widget is a consumer of a provider, allowing it to react to changes
/// in the state of the editor and update the line numbers accordingly.
///
/// The `LineNumber` widget is typically used in conjunction with a text editor
/// to provide a visual reference for the lines of text, enhancing the user
/// experience by making it easier to navigate and reference specific lines.
///
/// This widget should be placed alongside the text editor widget in the UI
/// layout to ensure proper alignment and functionality.
class LineNumber extends ConsumerWidget {
  /// A widget that displays the line number for a given node in the editor.
  ///
  /// The [LineNumber] widget takes a [node] and an [index] as required
  /// parameters.
  /// The [node] represents the content node for which the line number is being
  /// displayed,
  /// and the [index] represents the position of the line within the node.
  ///
  /// Example usage:
  /// ```dart
  /// LineNumber(node, index);
  /// ```
  ///
  /// Parameters:
  /// - [node]: The content node for which the line number is being displayed.
  /// - [index]: The position of the line within the node.
  const LineNumber(this.node, this.index, {super.key});

  /// A final variable representing an inline node in the editor.
  /// This node is used to manage and display inline elements within the file
  /// view.
  final Inline node;

  /// The index of the line in the file view.
  ///
  /// This represents the position of the line within the file, starting from 0.
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 30,
      child: Container(
        alignment: Alignment.center,
        height: node.textHeight,
        child: Text(
          '${index + 1}',
        ),
      ),
    );
  }
}
