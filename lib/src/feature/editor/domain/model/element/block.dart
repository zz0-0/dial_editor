import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

base class Block extends Node {
  Block({
    required super.key,
    super.parentKey,
  }) : children = [] {
    type = MarkdownElement.block.type;
  }
  List<Node> children;
  @override
  String toString() {
    return children.toString();
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'children': children.map((child) => child.toMap()).toList(),
    };
  }
}
