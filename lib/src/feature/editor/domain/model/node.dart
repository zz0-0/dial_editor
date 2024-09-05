/// library for markdown element
library node;

import 'dart:collection';

import 'package:dial_editor/src/feature/editor/domain/model/attribute.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class Node extends LinkedListEntry<Node> {
  String type = MarkdownElement.node.type;

  GlobalKey<EditableTextState> key = GlobalKey<EditableTextState>();
  GlobalKey<EditableTextState>? parentKey;
  Attribute attribute = Attribute();

  Node({required this.key, this.parentKey});

  factory Node.fromMap(Map<String, dynamic> map) => Node(
        key: map['key'] as GlobalKey<EditableTextState>,
        parentKey: map['parentKey'] as GlobalKey<EditableTextState>?,
      );

  Map<String, dynamic> toMap() => {
        'key': key,
        'type': type,
        'parentKey': parentKey,
      };
}
