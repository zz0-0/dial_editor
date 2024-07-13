import 'package:dial_editor/src/feature/editor/domain/entity/element/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';
import 'package:latext/latext.dart';

class Math extends Node {
  Math(super.context, super.rawText) {
    controller.text = rawText;
  }

  @override
  Node createNewLine() {
    return TextNode(context, "");
  }

  @override
  Widget render() {
    updateStyle();
    updateTextHeight();
    return _buildRichText();
  }

  @override
  void updateStyle() {
    final theme = Theme.of(context);
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
        text,
        style: style,
      ),
    );

    // return RichText(
    //   text: TextSpan(
    //     style: Theme.of(context).textTheme.titleSmall,
    //     children: textSpans,
    //   ),
    // );
  }
}
