import 'package:dial_editor/src/feature/editor/domain/entity/element/block/block.dart';
import 'package:flutter/material.dart';

class Quote extends Block {
  Quote({
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
    text = newText.replaceAll('>', '').trim();
    updateStyle();
    updateTextHeight();
  }

  @override
  void updateStyle() {
    final theme = Theme.of(context);
    style = TextStyle(
      fontSize: theme.textTheme.titleSmall!.fontSize,
      fontStyle: FontStyle.italic,
      color: Colors.grey,
    );
  }

  @override
  String toString() {
    return rawText;
  }

  @override
  Quote createNewLine() {
    return Quote(context: context, rawText: "> ");
  }

  Widget _buildRichText() {
    text = rawText.replaceAll('>', '').trim();
    return Text(
      text,
      style: style,
    );
  }
}
