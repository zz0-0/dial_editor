/// library for markdown element
library node;

import 'dart:collection';

import 'package:dial_editor/src/feature/editor/domain/model/attribute.dart';
import 'package:flutter/material.dart';

base class Node extends LinkedListEntry<Node> {
  late GlobalKey documentKey;
  GlobalKey<EditableTextState> key = GlobalKey<EditableTextState>();
  GlobalKey<EditableTextState>? parentKey;
  final Map<String, Attribute> attributeMap = {};

  void setAttribute(String key, Attribute value) {
    attributeMap[key] = value;
  }

  Attribute? getAttribute(String key) {
    return attributeMap[key];
  }
}
