/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class Block extends Node {
  final List<Node> children;

  Block({
    required super.key,
  }) : children = [] {
    type = MarkdownElement.block.type;
  }

  @override
  String toString() {
    return children.toString();
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'type': type,
      'children': children.map((child) => child.toMap()).toList(),
    };
  }

  factory Block.fromMap(Map<String, dynamic> map) {
    final List<Block> children = [];
    for (final child in map['children'] as List) {
      children.add(Block.fromMap(child as Map<String, dynamic>));
    }
    return Block(
      key: map['key'] as GlobalKey<EditableTextState>,
    );
  }
}
