import 'package:dial_editor/src/feature/editor/domain/entity/element/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';

class Superscript extends Node {
  Superscript(super.context, super.rawText, [super.text]) {
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
    final regex = superscriptRegex;
    text = newText.replaceAll(regex, '').trim();
    updateStyle();
  }

  @override
  void updateStyle() {
    final theme = Theme.of(context);
    style = TextStyle(
      fontSize: theme.textTheme.bodyMedium!.fontSize! * 0.8,
      fontFeatures: const [FontFeature.superscripts()],
    );
  }

  Widget _buildRichText() {
    final regex = superscriptRegex;
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
          text: rawText.substring(match.start, match.end).replaceAll('^', ''),
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
        style: Theme.of(context).textTheme.bodyMedium,
        children: textSpans,
      ),
    );
  }

  @override
  String toString() {
    return rawText;
  }

  @override
  Node createNewLine() {
    return TextNode(context, "");
  }
}
