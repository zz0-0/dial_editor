import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class MarkdownRender {
  MarkdownRender();

  Text render(Node node) {
    return const Text("");
  }

  List<Text> renderList(List<Node> nodes) {
    final List<Text> markdownWidgetList = [];

    for (final node in nodes) {
      markdownWidgetList.add(render(node));
    }

    return markdownWidgetList;
  }
}
