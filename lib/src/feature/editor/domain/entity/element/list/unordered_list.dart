import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class UnorderedList extends Node {
  UnorderedList(super.context, super.rawText) {
    controller.text = rawText;
  }

  @override
  Widget render() {
    updateStyle();
    return _buildRichText();
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
      fontSize: theme.textTheme.titleSmall!.fontSize,
    );
  }

  @override
  String toString() {
    return rawText;
  }

  @override
  Node createNewLine() {
    return UnorderedList(context, "- ");
  }

  Widget _buildRichText() {
    return Text(
      rawText,
      style: style,
    );
  }
}
