import 'dart:collection';
import 'package:dial_editor/src/feature/editor/domain/model/attribute.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class Node extends LinkedListEntry<Node> {
  Node({required this.key, this.parentKey});
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
  String type = MarkdownElement.node.type;
  GlobalKey<EditableTextState> key = GlobalKey<EditableTextState>();
  GlobalKey<EditableTextState>? parentKey;
  Attribute attribute = Attribute();
  Map<String, dynamic> toMap() => {
        'key': key.toString(),
        'parentKey': parentKey.toString(),
        'type': type,
      };
}
