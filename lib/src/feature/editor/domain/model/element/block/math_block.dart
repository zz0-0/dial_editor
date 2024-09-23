/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a mathematical block element within the editor.
/// 
/// This class extends the [Block] class and is used to handle and represent
/// mathematical expressions or equations within the editor.
/// 
/// Example usage:
/// ```dart
/// MathBlock mathBlock = MathBlock();
/// // Additional operations on mathBlock
/// ```
/// 
/// See also:
/// - [Block], which is the base class for different types of blocks.
base class MathBlock extends Block {
  /// A class representing a mathematical block element in the editor.
  /// 
  /// This block is used to encapsulate and manage mathematical expressions
  /// within the editor. It provides necessary properties and methods to 
  /// handle the rendering and manipulation of math content.
  /// 
  /// Example usage:
  /// 
  /// ```dart
  /// MathBlock(
  ///   // initialization parameters
  /// );
  /// ```
  /// 
  /// Note: Ensure that the math rendering engine is properly configured
  /// to display the mathematical content correctly.
  MathBlock({
    required super.key,
    super.parentKey,
  }) {
    type = MarkdownElement.mathBlock.type;
  }

  /// Creates a [MathBlock] instance from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize a [MathBlock] object.
  ///
  /// Returns a [MathBlock] object.
  factory MathBlock.fromMap(Map<String, dynamic> map) {
    final block = MathBlock(
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
