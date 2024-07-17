import 'package:dial_editor/src/feature/editor/domain/model/element/inline/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';
import 'package:latext/latext.dart';

class Math extends Inline {
  Math({
    required super.context,
    required super.rawText,
    required super.parentKey,
  }) {
    controller.text = rawText;
  }

  @override
  Node createNewLine() {
    return TextNode(
      context: super.context,
      rawText: "",
      parentKey: super.parentKey,
    );
  }

  // @override
  // double updateTextHeight() {}

  @override
  Widget render() {
    updateStyle();
    updateTextHeight();
    return _buildRichText();
  }

  @override
  void updateStyle() {
    final theme = Theme.of(super.context);
    style = TextStyle(
      fontSize: theme.textTheme.titleSmall!.fontSize,
    );
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    final regex = inlineMathRegex;
    text = newText.replaceAll(regex, '').trim();
    updateStyle();
    updateTextHeight();
  }

  @override
  String toString() {
    return rawText;
  }

  Widget _buildRichText() {
    text = rawText.replaceAll('\$', '').trim();
    return LaTexT(
      laTeXCode: Text(
        rawText,
        style: style,
      ),
    );
  }
}