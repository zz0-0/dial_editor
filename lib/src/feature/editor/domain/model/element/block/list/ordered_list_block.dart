/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class OrderedListBlock extends Block {
  OrderedListBlock({
    required super.key,
    super.parentKey,
  }) {
    type = MarkdownElement.orderedListBlock.type;
  }

  factory OrderedListBlock.fromMap(Map<String, dynamic> map) {
    final block = OrderedListBlock(
      key: GlobalKey(debugLabel: map['key'] as String),
      parentKey: map['parentKey'] != null
          ? GlobalKey(debugLabel: map['parentKey'] as String)
          : null,
    );
    block.children = map['children'] != null
        ? (map['children'] as List)
            .map((child) => Node.fromMap(child as Map<String, dynamic>))
            .toList()
        : [];
    return block;
  }
}
