/// library for markdown element
library node;

import 'dart:collection';

import 'package:dial_editor/src/feature/editor/domain/model/attribute.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// Represents a node in a linked list structure.
///
/// This class extends `LinkedListEntry<Node>` to provide linked list
/// functionalities. It serves as a base class for other node types
/// that can be used within the editor domain.
///
/// The `Node` class can be extended to include additional properties
/// and methods specific to different types of nodes.
base class Node extends LinkedListEntry<Node> {
  /// Represents a node in the editor's data structure.
  ///
  /// Each node has a unique key and an optional parent key, which can be used
  /// to establish hierarchical relationships between nodes.
  ///
  /// - `key`: A unique identifier for this node.
  /// - `parentKey`: An optional identifier for the parent node, if any.
  Node({required this.key, this.parentKey});

  /// Creates a new instance of [Node] from a given map.
  ///
  /// The [map] parameter is a `Map<String, dynamic>` that contains the data
  /// necessary to instantiate a [Node].
  ///
  /// Returns a [Node] object populated with the data from the map.
  factory Node.fromMap(Map<String, dynamic> map) {
    final type = map['type'] as String;
    if (type == MarkdownElement.headingBlock.type) {
      return HeadingBlock.fromMap(map);
    } else if (type == MarkdownElement.heading.type) {
      return Heading.fromMap(map);
    } else if (type == MarkdownElement.orderedListBlock.type) {
      return OrderedListBlock.fromMap(map);
    } else if (type == MarkdownElement.orderedListNode.type) {
      return OrderedListNode.fromMap(map);
    } else if (type == MarkdownElement.taskListBlock.type) {
      return TaskListBlock.fromMap(map);
    } else if (type == MarkdownElement.taskListNode.type) {
      return TaskListNode.fromMap(map);
    } else if (type == MarkdownElement.unorderedListBlock.type) {
      return UnorderedListBlock.fromMap(map);
    } else if (type == MarkdownElement.unorderedListNode.type) {
      return UnorderedListNode.fromMap(map);
    } else if (type == MarkdownElement.boldItalic.type) {
      return BoldItalic.fromMap(map);
    } else if (type == MarkdownElement.bold.type) {
      return Bold.fromMap(map);
    } else if (type == MarkdownElement.emoji.type) {
      return Emoji.fromMap(map);
    } else if (type == MarkdownElement.highlight.type) {
      return Highlight.fromMap(map);
    } else if (type == MarkdownElement.horizontalRule.type) {
      return HorizontalRule.fromMap(map);
    } else if (type == MarkdownElement.image.type) {
      return ImageNode.fromMap(map);
    } else if (type == MarkdownElement.italic.type) {
      return Italic.fromMap(map);
    } else if (type == MarkdownElement.link.type) {
      return Link.fromMap(map);
    } else if (type == MarkdownElement.mathBlock.type) {
      return MathBlock.fromMap(map);
    } else if (type == MarkdownElement.math.type) {
      return Math.fromMap(map);
    } else if (type == MarkdownElement.strikethrough.type) {
      return Strikethrough.fromMap(map);
    } else if (type == MarkdownElement.subscript.type) {
      return Subscript.fromMap(map);
    } else if (type == MarkdownElement.text.type) {
      return TextNode.fromMap(map);
    } else if (type == MarkdownElement.quoteBlock.type) {
      return QuoteBlock.fromMap(map);
    } else if (type == MarkdownElement.quote.type) {
      return Quote.fromMap(map);
    } else if (type == MarkdownElement.superscript.type) {
      return Superscript.fromMap(map);
    } else if (type == MarkdownElement.codeBlock.type) {
      return CodeBlock.fromMap(map);
    } else if (type == MarkdownElement.codeBlockMarker.type) {
      return CodeBlockMarker.fromMap(map);
    } else if (type == MarkdownElement.codeLine.type) {
      return CodeLine.fromMap(map);
    } else {
      throw Exception('Unknown node type: $type');
    }
  }

  /// A string representing the type of the Markdown element node.
  /// This is initialized with the type value from the `MarkdownElement.node`.
  String type = MarkdownElement.node.type;

  /// A global key used to uniquely identify the state of an `EditableText`
  /// widget.
  ///
  /// This key allows access to the state of the `EditableText` widget, enabling
  /// operations such as programmatically manipulating the text or controlling
  /// the focus.
  ///
  /// Example usage:
  /// ```dart
  /// GlobalKey<EditableTextState> key = GlobalKey<EditableTextState>();
  /// ```
  GlobalKey<EditableTextState> key = GlobalKey<EditableTextState>();

  /// A key that references the parent `EditableTextState` widget.
  ///
  /// This key can be used to access and manipulate the state of the parent
  /// `EditableText` widget, allowing for advanced text editing features and
  /// interactions.
  ///
  /// The key is optional and can be `null`.
  GlobalKey<EditableTextState>? parentKey;

  /// An instance of the `Attribute` class.
  ///
  /// This object represents an attribute associated with a node in the editor
  /// domain model.
  Attribute attribute = Attribute();

  /// Converts the current instance to a map representation.
  ///
  /// This method serializes the instance into a `Map<String, dynamic>`,
  /// which can be useful for encoding the object into JSON or other
  /// key-value based formats.
  ///
  /// Returns a `Map<String, dynamic>` containing the key-value pairs
  /// representing the instance's properties.
  Map<String, dynamic> toMap() => {
        'key': key.toString(),
        'parentKey': parentKey.toString(),
        'type': type,
      };
}
