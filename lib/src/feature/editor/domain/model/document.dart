import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

class Document {
  GlobalKey key;
  List<Node> children;

  Document({required this.key, required this.children});

  @override
  String toString() {
    return children.map((e) => e.toString()).toList().join("\n");
  }
}
