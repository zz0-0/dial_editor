import 'package:dial_editor/src/feature/editor/domain/entity/element/heading.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class MarkdownRender {
  MarkdownRender();

  Widget render(Node node) {
    if (node is Heading) {
      return node.render();
    }

    return Container();
  }

  List<Widget> renderList(List<Node> nodes) {
    final List<Widget> markdownWidgetList = [];

    for (final node in nodes) {
      markdownWidgetList.add(render(node));
    }

    return markdownWidgetList;
  }
}
