import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class UnorderedListBlock extends Block {
  UnorderedListBlock({
    required super.key,
    super.parentKey,
  }) {
    type = MarkdownElement.unorderedListBlock.type;
  }
  factory UnorderedListBlock.fromMap(Map<String, dynamic> map) {
    final block = UnorderedListBlock(
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
