/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class UnorderedListBlock extends Block {
  UnorderedListBlock({required super.key}) {
    type = MarkdownElement.unorderedListBlock.type;
  }

  factory UnorderedListBlock.fromMap(Map<String, dynamic> map) {
    return UnorderedListBlock(key: map['key'] as GlobalKey<EditableTextState>);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'type': type,
    };
  }
}
