import 'package:dial_editor/src/feature/editor/domain/model/element/block/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';

class Heading extends Block {
  int? level;
  String? id;

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
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    final match = regex!.firstMatch(newText);
    if (match != null) {
      level = match.group(1)?.length ?? 1;
      text = match.group(2)!;
      id = match.group(3);
      id ??= generateCustomId(text);
    }
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
    text = rawText.replaceAll(regex!, '').trim();
    updateStyle();
    updateTextHeight();
    return Text(
      text,
      style: style,
    );
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
}
