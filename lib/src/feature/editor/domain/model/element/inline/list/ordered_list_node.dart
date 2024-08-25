/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class OrderedListNode extends Inline {
  OrderedListNode({
    required super.rawText,
    required super.key,
  }) {
    type = MarkdownElement.orderedListNode.type;
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.orderedListNode);
  }

  @override
  Inline createNewLine() {
    final match = orderListRegex.firstMatch(rawText);
    if (match != null) {
      final currentNumber =
          int.tryParse(match.group(0)!.trim().replaceFirst('.', '')) ?? 0;
      final newNumber = currentNumber + 1;
      return OrderedListNode(
        key: super.key,
        rawText: "$newNumber. ",
      );
    }
    return OrderedListNode(
      key: super.key,
      rawText: "1. ",
    );
  }

  factory OrderedListNode.fromMap(Map<String, dynamic> map) {
    return OrderedListNode(
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
