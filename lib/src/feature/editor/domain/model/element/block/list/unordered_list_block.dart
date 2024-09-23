/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// Represents an unordered list block element in the editor.
///
/// This class extends the [Block] class and is used to define
/// a block of content that is formatted as an unordered list.
///
/// Example usage:
/// ```dart
/// UnorderedListBlock myListBlock = UnorderedListBlock();
/// ```
///
/// This class can be used in conjunction with other block elements
/// to create complex document structures within the editor.
base class UnorderedListBlock extends Block {
  /// Represents an unordered list block element in the editor.
  UnorderedListBlock({
    required super.key,
    super.parentKey,
  }) {
    type = MarkdownElement.unorderedListBlock.type;
  }

  /// Creates an instance of [UnorderedListBlock] from a map.
  ///
  /// The [map] parameter is a [Map] containing key-value pairs that correspond
  /// to the properties of [UnorderedListBlock].
  ///
  /// Returns an [UnorderedListBlock] populated with the data from the [map].
  factory UnorderedListBlock.fromMap(Map<String, dynamic> map) {
    final block = UnorderedListBlock(
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
