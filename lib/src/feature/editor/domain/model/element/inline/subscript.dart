/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a subscript element in an inline context.
///
/// This class extends the [Inline] class and is used to denote text that should
/// be displayed as subscript, typically appearing slightly below the normal
/// line
/// of text and in a smaller font size.
///
/// Example usage:
///
/// ```dart
/// Subscript subscriptElement = Subscript();
/// ```
///
/// This can be useful in mathematical formulas, chemical formulas, or any other
/// context where subscript notation is required.
base class Subscript extends Inline {
  /// A class representing a subscript element in the editor domain model.
  ///
  /// This class is used to define and manage subscript text within the editor.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Subscript(
  ///   // parameters
  /// );
  /// ```
  ///
  /// The `Subscript` class can be used to create and manipulate subscript text
  /// elements,
  /// which are typically used in mathematical or scientific notation to denote
  /// text that
  /// appears slightly below the normal line of type.
  Subscript({
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
    type = MarkdownElement.subscript.type;
  }

  /// Creates a [Subscript] instance from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize a [Subscript] object.
  ///
  /// - `map`: A [Map] containing the data to create a [Subscript] instance.
  ///
  /// Returns a [Subscript] object initialized with the values from the map.
  factory Subscript.fromMap(Map<String, dynamic> map) {
    return Subscript(
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
    return TextRenderInstruction(rawText, MarkdownElement.subscript);
  }
}
