import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

abstract class NodeRepository {
  (List<GlobalKey>, Map<GlobalKey, Node>) convertDocument(List<String> lines);
  Inline convert(String input);
}
