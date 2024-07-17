import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';

class MarkdownRender {
  MarkdownRender();

  Widget render(Node node) {
    return node.render();
  }

  List<Widget> renderList(List<Node> nodes) {
    final List<Widget> markdownWidgetList = [];

    for (final node in nodes) {
      markdownWidgetList.add(render(node));
    }

    return markdownWidgetList;
  }
}
