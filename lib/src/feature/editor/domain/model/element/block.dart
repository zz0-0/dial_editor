/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

/// A base class representing a block element in the editor's domain model.
///
/// This class extends the [Node] class and serves as a foundation for
/// various types of block elements within the editor.
///
/// Blocks are typically used to represent larger structural elements
/// such as paragraphs, headings, or other container elements.
///
/// This class is intended to be extended by more specific block types.
base class Block extends Node {
  /// Represents a block element in the editor domain model.
  ///
  /// This class is used to define a block element which can be part of the
  /// editor's content. It encapsulates the properties and behaviors associated
  /// with a block element.
  Block({
    required super.key,
    super.parentKey,
  }) : children = [] {
    type = MarkdownElement.block.type;
  }

  /// A list of child nodes contained within this block element.
  ///
  /// This list represents the hierarchical structure of the block,
  /// allowing it to contain other nodes as its children.
  List<Node> children;

  @override
  String toString() {
    return children.toString();
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'children': children.map((child) => child.toMap()).toList(),
    };
  }
}
