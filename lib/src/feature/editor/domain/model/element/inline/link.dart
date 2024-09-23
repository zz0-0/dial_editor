/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// Represents a hyperlink within an inline element in the editor.
///
/// This class extends the `Inline` class and is used to define a link
/// element that can be embedded within other inline elements.
///
/// Example usage:
/// ```dart
/// Link link = Link();
/// ```
///
/// The `Link` class can be used to create and manipulate hyperlink elements
/// within the editor's content.
base class Link extends Inline {
  /// Represents a hyperlink element within the editor.
  ///
  /// This class is used to define a link with specific attributes such as
  /// the URL and the display text.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Link(
  ///   url: 'https://example.com',
  ///   text: 'Click here',
  /// );
  /// ```
  ///
  /// Properties:
  /// - `url`: The destination URL of the link.
  /// - `text`: The display text for the link.
  Link({
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
    type = MarkdownElement.link.type;
  }

  /// Creates a [Link] instance from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to initialize the [Link] object.
  ///
  /// Returns a [Link] object.
  factory Link.fromMap(Map<String, dynamic> map) {
    return Link(
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
    return TextRenderInstruction(rawText, MarkdownElement.link);
  }
}
