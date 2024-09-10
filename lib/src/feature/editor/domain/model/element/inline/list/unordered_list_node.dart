/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class UnorderedListNode extends Inline {
  UnorderedListNode({
    required super.key,
    super.parentKey,
    required super.rawText,
    super.text,
    super.textHeight,
    super.isBlockStart,
    super.isEditing,
    super.isExpanded,
    super.depth,
  }) {
    type = MarkdownElement.unorderedListNode.type;
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.unorderedListNode);
  }

  @override
  Inline createNewLine() {
    return UnorderedListNode(
      key: super.key,
      rawText: "- ",
    );
  }

  factory UnorderedListNode.fromMap(Map<String, dynamic> map) {
    return UnorderedListNode(
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
}
