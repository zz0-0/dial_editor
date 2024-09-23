/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A base class representing a heading element in the inline editor domain.
///
/// This class extends the [Inline] class and is used to define heading elements
/// within the editor. It serves as a foundation for different levels of
/// headings
/// (e.g., H1, H2, H3) that can be used in the editor.
///
/// Example usage:
/// ```dart
/// class H1 extends Heading {
///   // Implementation for H1 heading
/// }
///
/// class H2 extends Heading {
///   // Implementation for H2 heading
/// }
/// ```
///
/// See also:
/// - [Inline], which is the base class for all inline elements.
base class Heading extends Inline {
  /// Represents a heading element in the editor.
  ///
  /// This class is used to define a heading with specific properties
  /// that can be used within the editor domain.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Heading(
  ///   // properties
  /// );
  /// ```
  ///
  /// Properties:
  /// - Add a list of properties here with descriptions.
  Heading({
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
    type = MarkdownElement.heading.type;
  }

  /// Creates a new instance of [Heading] from a given map.
  ///
  /// The [map] parameter is a [Map] containing key-value pairs that correspond
  /// to the properties of the [Heading] object.
  ///
  /// Returns a [Heading] object populated with the values from the map.
  factory Heading.fromMap(Map<String, dynamic> map) {
    return Heading(
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

  /// Represents the heading level in a markdown editor.
  ///
  /// The `level` indicates the depth of the heading, where a higher number
  /// corresponds to a deeper heading level. For example, a level of 1 might
  /// represent an `<h1>` tag in HTML, while a level of 2 might represent an
  /// `<h2>` tag.
  int level = 0;

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.heading);
  }
}
