import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class Code extends Node {
  Code(super.context, super.rawText, [super.text]);

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
  String toString() {
    return rawText;
  }

  @override
  void updateStyle() {
    final theme = Theme.of(context);
    style = TextStyle(
      fontSize: theme.textTheme.titleSmall!.fontSize,
    );
  }

  @override
  Node createNewLine() {
    return Code(context, '');
  }

  Widget _buildRichText() {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        rawText,
        style: style,
      ),
    );
  }
}
