import 'package:dial_editor/src/feature/editor/domain/entity/element/block/block.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';

class Heading extends Block {
  int level;
  final regex = headingRegex;

  Heading({
    required super.context,
    required super.rawText,
    required this.level,
    super.style,
    super.text,
  }) {
    controller.text = rawText;
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    text = newText.replaceAll(regex, '').trim();
    level = regex.allMatches(newText).first.group(0)?.length ?? 1;
    updateStyle();
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
    text = rawText.replaceAll(regex, '').trim();
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
    return TextNode(context: super.context, rawText: "");
  }
}
