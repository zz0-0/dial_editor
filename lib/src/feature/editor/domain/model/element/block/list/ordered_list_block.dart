/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class OrderedListBlock extends Block {
  OrderedListBlock({required super.key}) {
    type = MarkdownElement.orderedListBlock.type;
  }

  factory OrderedListBlock.fromMap(Map<String, dynamic> map) {
    return OrderedListBlock(key: map['key'] as GlobalKey<EditableTextState>);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'type': type,
    };
  }
}
