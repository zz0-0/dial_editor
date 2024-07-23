import 'package:dial_editor/src/feature/editor/domain/model/element/inline/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class EmojiNode extends Inline {
  EmojiNode({
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
    return _buildEmoji();
  }

  @override
  void updateText(String newText) {
    rawText = newText;

    final parser = EmojiParser();
    final parsedEmoji = parser.emojify(newText);
    text = parsedEmoji.replaceAll(regex!, '').trim();
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
  Node createNewLine() {
    return TextNode(
      context: super.context,
      rawText: "",
      parentKey: super.parentKey,
    );
  }

  @override
  String toString() {
    return rawText;
  }

  Widget _buildEmoji() {
    final parser = EmojiParser();
    final parsedEmoji = parser.emojify(rawText);
    final theme = Theme.of(super.context);
    return Text(
      parsedEmoji,
      style: TextStyle(
        fontSize: theme.textTheme.titleSmall!.fontSize,
      ),
    );
  }
}
