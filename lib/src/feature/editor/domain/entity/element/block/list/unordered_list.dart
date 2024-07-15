import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class UnorderedList extends Node {
  UnorderedList({
    required super.context,
    required super.rawText,
  }) {
    controller.text = rawText;
  }

  @override
  Widget render() {
    updateStyle();
    updateTextHeight();
    return _buildRichText();
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    updateStyle();
    updateTextHeight();
  }

  @override
  void updateStyle() {
    final theme = Theme.of(super.context);
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
    return UnorderedList(context: super.context, rawText: "- ");
  }

  Widget _buildRichText() {
    return Text(
      rawText,
      style: style,
    );
  }
}
