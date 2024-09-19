import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/core/provider/theme/theme_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/dark.dart';
import 'package:flutter_highlighter/themes/github.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RenderAdapter {
  Ref ref;

  RenderAdapter(this.ref);

  Widget adapt(
    Inline node,
    RenderInstruction instruction,
    BuildContext context,
  ) {
    if (instruction is TextRenderInstruction) {
      final TextStyle newStyle =
          _getTextStyle(instruction.text, instruction.formatting);

      ref.read(updateNodeStyleUseCaseProvider)(node, newStyle);
      final double newHeight = _calculateHeight(node, context);
      if (node.textHeight != newHeight) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref
              .read(nodeStateProvider(node.key).notifier)
              .updateNodeHeight(context);
        });
      }
      if (node is CodeLine) {
        return HighlightView(
          instruction.text,
          language: 'c',
          theme: Theme.of(context).brightness == Brightness.dark
              ? darkTheme
              : githubTheme,
          textStyle: newStyle,
        );
      } else {
        return Text(
          instruction.text,
          style: newStyle,
        );
      }
    }
    return const Text("");
  }

  double _calculateHeight(Inline node, BuildContext context) {
    final text = node.controller.text;
    final style = node.style;
    final maxWidth = MediaQuery.of(context).size.width;

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.height;
  }

  TextStyle _getTextStyle(String text, MarkdownElement formatting) {
    final theme = ref.watch(themeProvider);
    final fontSize = theme.themeData.textTheme.titleSmall!.fontSize;
    final textColor = theme.themeData.textTheme.titleSmall!.color;
    final textTheme = theme.themeData.textTheme;

    switch (formatting) {
      case MarkdownElement.codeBlockMarker:
        return TextStyle(fontSize: fontSize, color: textColor);
      case MarkdownElement.codeLine:
        return TextStyle(fontSize: fontSize, color: textColor);
      case MarkdownElement.orderedListNode:
        return TextStyle(fontSize: fontSize, color: textColor);
      case MarkdownElement.taskListNode:
        return TextStyle(fontSize: fontSize, color: textColor);
      case MarkdownElement.unorderedListNode:
        return TextStyle(fontSize: fontSize, color: textColor);
      case MarkdownElement.boldItalic:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: textColor,
        );
      case MarkdownElement.bold:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      case MarkdownElement.emoji:
        return TextStyle(fontSize: fontSize, color: textColor);
      case MarkdownElement.heading:
        final match = headingRegex.firstMatch(text);
        TextStyle style = TextStyle(fontSize: fontSize, color: textColor);
        if (match != null) {
          final level = match.group(0)!.length;
          switch (level) {
            case 1:
              style = TextStyle(
                fontSize: textTheme.headlineLarge!.fontSize,
                color: textColor,
              );
            case 2:
              style = TextStyle(
                fontSize: textTheme.headlineMedium!.fontSize,
                color: textColor,
              );
            case 3:
              style = TextStyle(
                fontSize: textTheme.headlineSmall!.fontSize,
                color: textColor,
              );
            case 4:
              style = TextStyle(
                fontSize: textTheme.titleLarge!.fontSize,
                color: textColor,
              );
            case 5:
              style = TextStyle(
                fontSize: textTheme.titleMedium!.fontSize,
                color: textColor,
              );
            case 6:
              style = TextStyle(
                fontSize: textTheme.titleSmall!.fontSize,
                color: textColor,
              );
          }
        }
        return style;
      case MarkdownElement.highlight:
        return TextStyle(fontSize: fontSize, color: textColor);
      case MarkdownElement.horizontalRule:
        return TextStyle(fontSize: fontSize, color: textColor);
      case MarkdownElement.image:
        return TextStyle(
          fontSize: fontSize,
          decoration: TextDecoration.underline,
          color: textColor,
        );
      case MarkdownElement.italic:
        return TextStyle(
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
          color: textColor,
        );
      case MarkdownElement.link:
        return TextStyle(
          fontSize: fontSize,
          decoration: TextDecoration.underline,
          color: textColor,
        );
      case MarkdownElement.math:
        return TextStyle(fontSize: fontSize, color: textColor);
      case MarkdownElement.quote:
        return TextStyle(fontSize: fontSize, color: textColor);
      case MarkdownElement.strikethrough:
        return TextStyle(
          fontSize: fontSize,
          decoration: TextDecoration.lineThrough,
          color: textColor,
        );
      case MarkdownElement.subscript:
        return TextStyle(fontSize: fontSize, color: textColor);
      case MarkdownElement.superscript:
        return TextStyle(fontSize: fontSize, color: textColor);
      default:
        return TextStyle(fontSize: fontSize, color: textColor);
    }
  }
}
