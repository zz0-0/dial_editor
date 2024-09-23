/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a block of code within a document.
///
/// This class extends the [Block] class and is used to encapsulate
/// a segment of code, providing additional functionality and
/// properties specific to code blocks.
base class CodeBlock extends Block {
  /// Represents a block of code within the editor.
  ///
  /// This class is used to encapsulate a segment of code, providing
  /// necessary properties and methods to handle code-specific
  /// functionalities within the editor.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// CodeBlock(
  ///   // initialization parameters
  /// );
  /// ```
  ///
  /// Properties:
  /// - Add relevant properties here.
  ///
  /// Methods:
  /// - Add relevant methods here.
  CodeBlock({
    required super.key,
    super.parentKey,
    this.language,
  }) {
    type = MarkdownElement.codeBlock.type;
  }

  /// Creates a [CodeBlock] instance from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize a [CodeBlock] object.
  ///
  /// Returns a [CodeBlock] object.
  factory CodeBlock.fromMap(Map<String, dynamic> map) {
    final block = CodeBlock(
      key: GlobalKey(debugLabel: map['key'] as String),
      parentKey: map['parentKey'] != null
          ? GlobalKey(debugLabel: map['parentKey'] as String)
          : null,
      language: map['language'] as String?,
    )..children = map['children'] != null
        ? (map['children'] as List)
            .map((child) => Node.fromMap(child as Map<String, dynamic>))
            .toList()
        : [];
    return block;
  }

  /// The programming language of the code block. This can be used to apply
  /// syntax highlighting or other language-specific features.
  ///
  /// Example values might include "dart", "python", "javascript", etc.
  String? language;
}
