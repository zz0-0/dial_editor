import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A use case class responsible for updating the style of a node in the editor.
///
/// This class provides the functionality to modify the style attributes of a
/// specific node within the editor domain. It encapsulates the logic required
/// to apply style changes to nodes, ensuring that the editor's state is
/// updated accordingly.
class UpdateNodeStyleUseCase {
  /// A use case for updating the style of a node in the editor.
  ///
  /// This use case is responsible for applying style changes to a specific node
  /// within the editor's document. It encapsulates the logic required to modify
  /// the node's appearance based on the provided style parameters.
  UpdateNodeStyleUseCase();

  /// Updates the style of a given inline node.
  ///
  /// This method takes an [Inline] node and applies a new [TextStyle] to it.
  ///
  /// - Parameters:
  ///   - node: The inline node whose style needs to be updated.
  ///   - newStyle: The new text style to be applied to the node.
  void call(Inline node, TextStyle newStyle) {
    node.style = newStyle;
  }
}
