import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/core/provider/theme/theme_provider.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/regex.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RenderAdapter {
  Ref ref;

  RenderAdapter(this.ref);

  Widget adapt(Inline node, RenderInstruction instruction) {
    if (instruction is TextRenderInstruction) {
      final TextStyle newStyle =
          _getTextStyle(instruction.text, instruction.formatting);

      ref.read(updateNodeStyleUseCaseProvider).update(node, newStyle);

      return Text(
        instruction.text,
        style: newStyle,
      );
    }
    return Container();
  }

  TextStyle _getTextStyle(String text, MarkdownElement formatting) {
    final theme = ref.watch(themeProvider);
    final fontSize = theme.themeData.textTheme.titleSmall!.fontSize;
    final textTheme = theme.themeData.textTheme;

    switch (formatting) {
      case MarkdownElement.heading:
        final match = headingRegex.firstMatch(text);
        TextStyle style = TextStyle(fontSize: fontSize);
        if (match != null) {
          final level = match.group(0)!.length;
          switch (level) {
            case 1:
              style = TextStyle(fontSize: textTheme.headlineLarge!.fontSize);
            case 2:
              style = TextStyle(fontSize: textTheme.headlineMedium!.fontSize);
            case 3:
              style = TextStyle(fontSize: textTheme.headlineSmall!.fontSize);
            case 4:
              style = TextStyle(fontSize: textTheme.titleLarge!.fontSize);
            case 5:
              style = TextStyle(fontSize: textTheme.titleMedium!.fontSize);
            case 6:
              style = TextStyle(fontSize: textTheme.titleSmall!.fontSize);
          }
        }
        return style;
      case MarkdownElement.orderedListNode:
        return TextStyle(fontSize: fontSize);
      case MarkdownElement.taskListNode:
        return TextStyle(fontSize: fontSize);
      case MarkdownElement.unorderedListNode:
        return TextStyle(fontSize: fontSize);
      case MarkdownElement.boldItalic:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        );
      case MarkdownElement.bold:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        );
      case MarkdownElement.emoji:
        return TextStyle(fontSize: fontSize);
      case MarkdownElement.highlight:
        return TextStyle(fontSize: fontSize);
      case MarkdownElement.horizontalRule:
        return TextStyle(fontSize: fontSize);
      case MarkdownElement.image:
        return TextStyle(
          fontSize: fontSize,
          decoration: TextDecoration.underline,
        );
      case MarkdownElement.italic:
        return TextStyle(
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
        );
      case MarkdownElement.link:
        return TextStyle(
          fontSize: fontSize,
          decoration: TextDecoration.underline,
        );
      case MarkdownElement.math:
        return TextStyle(fontSize: fontSize);
      case MarkdownElement.strikethrough:
        return TextStyle(
          fontSize: fontSize,
          decoration: TextDecoration.lineThrough,
        );
      case MarkdownElement.subscipt:
        return TextStyle(fontSize: fontSize);
      case MarkdownElement.superscipt:
        return TextStyle(fontSize: fontSize);
      default:
        return TextStyle(fontSize: fontSize);
    }
  }
}
