import 'package:dial_editor/src/feature/editor/domain/model/element/inline/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';

class Italic extends Inline {
  Italic({
    required super.context,
    required super.rawText,
    required super.parentKey,
    required super.regex,
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
    text = newText.replaceAll(regex!, '').trim();
    updateStyle();
    updateTextHeight();
  }

  @override
  String toString() {
    return rawText;
  }

  @override
  void updateStyle() {
    final theme = Theme.of(super.context);
    style = TextStyle(
      fontSize: theme.textTheme.titleSmall!.fontSize,
      fontStyle: FontStyle.italic,
    );
  }

  @override
  Node createNewLine() {
    return TextNode(
      context: super.context,
      rawText: "",
      parentKey: super.parentKey,
    );
  }

  Widget _buildRichText() {
    final matches = regex!.allMatches(rawText);
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
          text: rawText.substring(match.start + 1, match.end - 1),
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
