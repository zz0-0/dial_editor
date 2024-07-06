import 'package:dial_editor/src/feature/editor/domain/entity/element/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class EmojiNode extends Node {
  EmojiNode(super.context, super.rawText) {
    controller.text = rawText;
  }

  @override
  Widget render() {
    updateStyle();
    return _buildEmoji();
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    final regex = emojiRegex;
    final parser = EmojiParser();
    final parsedEmoji = parser.emojify(newText);
    text = parsedEmoji.replaceAll(regex, '').trim();
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
  Node createNewLine() {
    return TextNode(context, "");
  }

  Widget _buildEmoji() {
    final parser = EmojiParser();
    final parsedEmoji = parser.emojify(rawText);
    final theme = Theme.of(context);
    return Text(
      parsedEmoji,
      style: TextStyle(
        fontSize: theme.textTheme.titleSmall!.fontSize,
      ),
    );
  }

  @override
  String toString() {
    return rawText;
  }
}
