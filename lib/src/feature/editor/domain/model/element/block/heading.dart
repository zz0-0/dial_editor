import 'package:dial_editor/src/feature/editor/domain/model/element/block/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';

class Heading extends Block {
  int? level;
  String? heading;
  String? id;
  TextStyle? idStyle;

  Heading({
    required super.context,
    required super.rawText,
    required super.blockKey,
    required super.regex,
    super.style,
    super.text,
    super.children,
    super.parentKey,
  }) {
    controller.text = rawText;
    matchRegex();
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    matchRegex();
    updateStyle();
    updateIdStyle();
    updateTextHeight();
  }

  @override
  void updateStyle() {
    final theme = Theme.of(super.context);
    switch (level) {
      case 1:
        style = theme.textTheme.headlineLarge!
            .copyWith(color: theme.textTheme.titleLarge!.color);
      case 2:
        style = theme.textTheme.headlineMedium!
            .copyWith(color: theme.textTheme.titleLarge!.color);
      case 3:
        style = theme.textTheme.headlineSmall!
            .copyWith(color: theme.textTheme.titleLarge!.color);
      case 4:
        style = theme.textTheme.titleLarge!
            .copyWith(color: theme.textTheme.titleLarge!.color);
      case 5:
        style = theme.textTheme.titleMedium!
            .copyWith(color: theme.textTheme.titleMedium!.color);
      case 6:
        style = theme.textTheme.titleSmall!
            .copyWith(color: theme.textTheme.titleSmall!.color);
      default:
    }
  }

  @override
  Widget render() {
    updateStyle();
    updateIdStyle();
    updateTextHeight();
    return _buildRichText();
  }

  @override
  String toString() {
    return rawText;
  }

  @override
  Node createNewLine() {
    return TextNode(
      context: super.context,
      rawText: "",
      parentKey: super.parentKey,
    );
  }

  String? generateCustomId(String text) {
    return text.hashCode.toString();
  }

  void matchRegex() {
    final match = regex!.firstMatch(rawText);
    if (match != null) {
      level = match.group(1)?.length ?? 1;
      heading = match.group(1);
      text = match.group(2)!.trim();

      final idMatch = RegExp(r'\s*\{#(.*?)\}$').firstMatch(text);
      if (idMatch != null) {
        id = idMatch.group(1);
        text = text.substring(0, text.length - idMatch.group(0)!.length).trim();
      } else {
        id = generateCustomId(text);
      }
      rawText = "$heading $text {#$id}";
    } else {
      text = rawText.trim();
      id = generateCustomId(text);
      rawText = "$text {#$id}";
    }

    // updateStyle();
    // updateIdStyle();
    // updateTextHeight();
  }

  void updateIdStyle() {
    idStyle = style.copyWith(backgroundColor: Colors.yellow);
  }

  Widget _buildRichText() {
    final headingText = heading != null ? '$heading ' : '';
    final mainText = text;
    final idText = id ?? '';

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: headingText, style: style),
          TextSpan(text: mainText, style: style),
          TextSpan(text: " ", style: style),
          TextSpan(text: idText, style: idStyle),
        ],
      ),
    );
  }
}
