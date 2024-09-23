/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing an ordered list block in the editor domain.
///
/// This class extends the [Block] class and is used to model an ordered list
/// within the editor. It provides the necessary functionality to handle
/// ordered list elements in the editor's domain model.
base class OrderedListBlock extends Block {
  /// Represents an ordered list block element in the editor.
  ///
  /// This class is used to define and manage ordered list blocks within the
  /// editor domain. It provides the necessary properties and methods to
  /// handle ordered list elements.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// OrderedListBlock(
  ///   // initialization parameters
  /// );
  /// ```
  ///
  /// You can customize the ordered list block by providing specific parameters
  /// during initialization.
  OrderedListBlock({
    required super.key,
    super.parentKey,
  }) {
    type = MarkdownElement.orderedListBlock.type;
  }

  /// Creates an instance of [OrderedListBlock] from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize the [OrderedListBlock] instance.
  ///
  /// Returns an [OrderedListBlock] object.
  factory OrderedListBlock.fromMap(Map<String, dynamic> map) {
    final block = OrderedListBlock(
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
