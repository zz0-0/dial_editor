import 'package:dial_editor/src/feature/editor/domain/entity/element/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';

class Heading extends Node {
  int level;
  final regex = headingRegex;

  Heading(
    BuildContext context,
    this.level,
    String rawText, [
    TextStyle style = const TextStyle(),
    String text = "",
  ]) : super(context, rawText, style, text) {
    controller.text = rawText;
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    text = newText.replaceAll(regex, '').trim();
    level = regex.allMatches(newText).first.group(0)?.length ?? 1;
    updateStyle();
  }

  @override
  void updateStyle() {
    final theme = Theme.of(context);
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
    return TextNode(context, "");
  }
}
