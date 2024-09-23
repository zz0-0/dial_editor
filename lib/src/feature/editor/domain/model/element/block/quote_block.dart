/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a block of quoted text within a document.
/// 
/// This class extends the [Block] class and is used to encapsulate
/// a section of text that is intended to be displayed as a quote.
/// 
/// Example usage:
/// ```dart
/// QuoteBlock quote = QuoteBlock();
/// // Add content to the quote block
/// ```
/// 
/// This can be useful for formatting text in a way that distinguishes
/// quoted sections from the rest of the document.
base class QuoteBlock extends Block {
  /// Represents a block of quoted text within the editor.
  /// 
  /// This class is used to encapsulate and manage the properties
  /// and behaviors associated with a quote block element in the
  /// editor domain.
  /// 
  /// Example usage:
  /// ```dart
  /// QuoteBlock(
  ///   // initialization parameters
  /// );
  /// ```
  /// 
  /// The `QuoteBlock` can be used to display quoted text with
  /// specific styling or formatting within the editor.
  QuoteBlock({
    required super.key,
    super.parentKey,
  }) {
    type = MarkdownElement.quoteBlock.type;
  }

  /// Creates a [QuoteBlock] instance from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize a [QuoteBlock] object.
  ///
  /// Returns a [QuoteBlock] object.
  factory QuoteBlock.fromMap(Map<String, dynamic> map) {
    final block = QuoteBlock(
      key: GlobalKey(debugLabel: map['key'] as String),
      parentKey: map['parentKey'] != null
          ? GlobalKey(debugLabel: map['parentKey'] as String)
          : null,
    )..children = map['children'] != null
        ? (map['children'] as List)
            .map((child) => Node.fromMap(child as Map<String, dynamic>))
            .toList()
        : [];
    return block;
  }
}
