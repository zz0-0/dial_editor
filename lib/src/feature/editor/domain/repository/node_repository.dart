import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

abstract class NodeRepository {
  List<Node> convertDocument(GlobalKey key, List<String> lines);
  Inline convert(String input);
}
