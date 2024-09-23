/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a heading block in the editor.
///
/// This class extends the [Block] class and is used to define
/// heading elements within the editor. It can be used to create
/// different levels of headings (e.g., H1, H2, H3) in the document.
base class HeadingBlock extends Block {
  /// A class representing a heading block element in the editor.
  ///
  /// This block is used to define headings within the editor, allowing for
  /// different levels of headings to be created.
  ///
  /// Example usage:
  /// ```dart
  /// HeadingBlock(
  ///   // parameters
  /// );
  /// ```
  ///
  /// Parameters:
  /// - `level`: The level of the heading (e.g., 1 for H1, 2 for H2).
  /// - `text`: The text content of the heading.
  HeadingBlock({
    required super.key,
    required this.level,
    super.parentKey,
  }) {
    type = MarkdownElement.headingBlock.type;
  }

  /// Creates a new instance of [HeadingBlock] from a given map.
  ///
  /// The [map] parameter is a `Map<String, dynamic>` that contains the data
  /// necessary to instantiate a [HeadingBlock].
  ///
  /// Returns a [HeadingBlock] object populated with the data from the map.
  factory HeadingBlock.fromMap(Map<String, dynamic> map) {
    final block = HeadingBlock(
      key: GlobalKey(debugLabel: map['key'] as String),
      parentKey: map['parentKey'] != null
          ? GlobalKey(debugLabel: map['parentKey'] as String)
          : null,
      level: map['level'] as int? ?? 1,
    )..children = map['children'] != null
        ? (map['children'] as List)
            .map((child) => Node.fromMap(child as Map<String, dynamic>))
            .toList()
        : [];
    return block;
  }

  /// Represents the heading level of a block element.
  ///
  /// The `level` indicates the importance of the heading, with lower
  /// numbers representing higher importance (e.g., 1 for the main heading,
  /// 2 for subheadings, etc.).
  int level;
}
