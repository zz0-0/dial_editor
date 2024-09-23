/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a superscript element in an inline context.
///
/// This class extends the [Inline] class and is used to denote text that should
/// be displayed as superscript, typically used for footnotes, mathematical
/// exponents, or other annotations.
///
/// Example usage:
///
/// ```dart
/// Superscript superscript = Superscript();
/// ```
base class Superscript extends Inline {
  /// A class representing a superscript element in the editor domain model.
  ///
  /// This class is used to define text that should be displayed as superscript,
  /// which is typically rendered with a smaller font size and positioned
  /// slightly
  /// above the baseline of the normal text.
  ///
  /// Example usage:
  /// ```dart
  /// Superscript(
  ///   // properties and initialization
  /// );
  /// ```
  ///
  /// Note: Ensure that the rendering logic for superscript text is properly
  /// handled in the UI layer to achieve the desired visual effect.
  Superscript({
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
    type = MarkdownElement.superscript.type;
  }

  /// Creates a [Superscript] instance from a map.
  ///
  /// The [map] parameter is a [Map] containing key-value pairs that correspond
  /// to the properties of the [Superscript] instance.
  ///
  /// Returns a [Superscript] object populated with the values from the map.
  factory Superscript.fromMap(Map<String, dynamic> map) {
    return Superscript(
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
    return TextRenderInstruction(rawText, MarkdownElement.superscript);
  }
}
