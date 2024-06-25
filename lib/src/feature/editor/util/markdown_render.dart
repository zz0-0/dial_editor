import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class MarkdownRender {
  MarkdownRender();

  Text render(Node node) {
    if (node is Element) {
      if (node.tag == 'h1') {
        return Text(
          node.text,
          style: const TextStyle(
            fontSize: 40,
            color: Colors.black,
          ),
        );
      } else if (node.tag == 'h2') {
        return Text(
          node.text,
          style: const TextStyle(
            fontSize: 36,
            color: Colors.black,
          ),
        );
      } else if (node.tag == 'h3') {
        return Text(
          node.text,
          style: const TextStyle(
            fontSize: 32,
            color: Colors.black,
          ),
        );
      } else if (node.tag == 'h4') {
        return Text(
          node.text,
          style: const TextStyle(
            fontSize: 28,
            color: Colors.black,
          ),
        );
      } else if (node.tag == 'h5') {
        return Text(
          node.text,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        );
      } else if (node.tag == 'h6') {
        return Text(
          node.text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        );
      } else if (node.tag == 'p') {
        return Text(node.text);
      } else if (node.tag == 'blockquote') {
        return Text(node.text);
      } else if (node.tag == 'ul') {
        return Text(node.text);
      } else if (node.tag == 'code') {
        return Text(node.text);
      }
      // else if (node.tag == '') {
      //   Text(node.text);
      // } else if (node.tag == '') {
      //   Text(node.text);
      // } else if (node.tag == '') {
      //   Text(node.text);
      // } else if (node.tag == '') {
      //   Text(node.text);
      // } else if (node.tag == '') {
      //   Text(node.text);
      // } else if (node.tag == '') {
      //   Text(node.text);
      // } else if (node.tag == '') {
      //   Text(node.text);
      // } else if (node.tag == '') {
      //   Text(node.text);
      // } else if (node.tag == '') {
      //   Text(node.text);
      // } else if (node.tag == '') {
      //   Text(node.text);
      // }
      else {
        return Text(node.text);
      }
    }
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
