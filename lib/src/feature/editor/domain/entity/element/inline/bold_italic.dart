import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';

class BoldItalic extends Inline {
  BoldItalic({
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
    final regex = boldItalicRegex;
    text = newText.replaceAll(regex, '').trim();
    updateStyle();
    updateTextHeight();
  }

  @override
  void updateStyle() {
    final theme = Theme.of(super.context);
    style = TextStyle(
      fontSize: theme.textTheme.titleSmall!.fontSize,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );
  }

  @override
  String toString() {
    return rawText;
  }

  @override
  Node createNewLine() {
    return TextNode(context: super.context, rawText: "");
  }

  Widget _buildRichText() {
    final regex = boldItalicRegex;
    final matches = regex.allMatches(rawText);
    if (matches.isEmpty) {
      return Text(
        rawText,
        style: style,
      );
    }

    final textSpans = <TextSpan>[];
    int currentPosition = 0;

    for (final match in matches) {
      if (match.start > currentPosition) {
        textSpans.add(
          TextSpan(
            text: rawText.substring(currentPosition, match.start),
          ),
        );
      }

      textSpans.add(
        TextSpan(
          text: rawText.substring(
            match.start + 3,
            match.end - 3,
          ),
          style: style,
        ),
      );

      currentPosition = match.end;
    }

    if (currentPosition < rawText.length) {
      textSpans.add(
        TextSpan(
          text: rawText.substring(currentPosition),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: Theme.of(super.context).textTheme.titleSmall,
        children: textSpans,
      ),
    );
  }
}
