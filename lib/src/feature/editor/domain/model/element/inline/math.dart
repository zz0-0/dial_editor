/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a mathematical element within an inline context.
///
/// This class extends the [Inline] class and is used to handle mathematical
/// expressions or elements that are part of inline content in the editor.
///
/// Example usage:
///
/// ```dart
/// Math mathElement = Math();
/// // Use mathElement in your inline content processing
/// ```
///
/// Note: This class is part of the domain model for the editor feature.
base class Math extends Inline {
  /// Represents a mathematical element within the editor.
  ///
  /// This class is used to handle and display mathematical expressions
  /// in the editor. It provides necessary properties and methods to
  /// manage the mathematical content.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Math(
  ///   // initialization parameters
  /// );
  /// ```
  ///
  /// Note: Ensure that the mathematical expressions are properly formatted
  /// and validated before passing them to this class.
  Math({
    required super.key,
    required super.rawText,
    super.parentKey,
    super.text,
    super.textHeight,
    super.isBlockStart,
    super.isEditing,
    super.isExpanded,
    super.depth,
  }) {
    type = MarkdownElement.math.type;
  }

  /// Creates an instance of [Math] from a map.
  ///
  /// The [map] parameter is a [Map] containing key-value pairs that correspond
  /// to the properties of the [Math] object.
  ///
  /// Returns a [Math] object populated with the values from the provided [map].
  factory Math.fromMap(Map<String, dynamic> map) {
    return Math(
      key: GlobalKey(debugLabel: map['key'] as String),
      parentKey: map['parentKey'] != null
          ? GlobalKey(debugLabel: map['parentKey'] as String)
          : null,
      rawText: map['rawText'] as String,
      text: map['text'] as String,
      textHeight: map['textHeight'] as double?,
      isBlockStart: map['isBlockStart'] as bool,
      isEditing: map['isEditing'] as bool,
      isExpanded: map['isExpanded'] as bool,
      depth: map['depth'] as int,
    );
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.math);
  }
}
