/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class UnorderedListNode extends Inline {
  UnorderedListNode({
    required super.rawText,
    required super.key,
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
      key: map['key'] as GlobalKey<EditableTextState>,
      rawText: map['rawText'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'type': type,
    };
  }
}
