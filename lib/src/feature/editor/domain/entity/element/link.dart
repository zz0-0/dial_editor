import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class Link extends Node {
  final String url;

  Link(super.context, super.rawText, this.url) {
    controller.text = rawText;
  }

  @override
  Widget render() {
    updateStyle();
    return _buildLink();
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    updateStyle();
  }

  @override
  void updateStyle() {
    final theme = Theme.of(context);
    style = TextStyle(
      fontSize: theme.textTheme.bodyMedium!.fontSize,
      color: Colors.blue,
      decoration: TextDecoration.underline,
    );
  }

  @override
  Node createNewLine() {
    return Link(context, "", "");
  }

  Widget _buildLink() {
    return GestureDetector(
      onTap: () {
        // Handle link tap, e.g., open the URL in a browser
      },
      child: Text(
        rawText,
        style: style,
      ),
    );
  }

  @override
  String toString() {
    return '[$rawText]($url)';
  }
}
