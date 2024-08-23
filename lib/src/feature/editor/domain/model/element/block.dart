/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

base class Block extends Node {
  List<Node> children = [];

  Block();

  @override
  String toString() {
    return children.toString();
  }
}
