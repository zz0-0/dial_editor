import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';

class Heading extends Node {
  int level;
  final regex = headingRegex;

  Heading(BuildContext context, this.level, String rawText, [String text = ""])
      : super(context, rawText, text) {
    // Node.registerParser('heading', Heading.parse);
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

  // factory Heading.parse(String line) {
  //   final regex = RegExp("^#{1,6}");

  //   if (regex.matchAsPrefix(line) != null) {
  //     final level = regex.allMatches(line).length;
  //     final rawText = line;
  //     final text = line.replaceAll(regex, '').trim();
  //     return Heading(level, rawText, text);
  //   }

  //   return Heading(1, "");
  // }

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
}
