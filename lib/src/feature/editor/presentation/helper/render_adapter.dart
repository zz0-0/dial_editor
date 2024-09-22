import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/core/provider/theme/theme_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart' as emoji;
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/dark.dart';
import 'package:flutter_highlighter/themes/github.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latext/latext.dart';

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
      } else if (node is Emoji) {
        return Text(
          emoji.EmojiParser().emojify(instruction.text),
          // style: newStyle,
        );
      } else if (node is Math) {
        return LaTexT(
          laTeXCode: Text(instruction.text),
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
    // final textColor =
    //     theme.themeMode == ThemeMode.dark ? Colors.black : Colors.white;
    final textTheme = theme.themeData.textTheme;

    switch (formatting) {
      case MarkdownElement.codeBlockMarker:
        return TextStyle(fontSize: fontSize);
      case MarkdownElement.codeLine:
        return TextStyle(fontSize: fontSize);
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
      case MarkdownElement.heading:
        final match = headingRegex.firstMatch(text);
        TextStyle style = TextStyle(fontSize: fontSize);
        if (match != null) {
          final level = match.group(0)!.length;
          switch (level) {
            case 1:
              style = TextStyle(
                fontSize: textTheme.headlineLarge!.fontSize,
              );
            case 2:
              style = TextStyle(
                fontSize: textTheme.headlineMedium!.fontSize,
              );
            case 3:
              style = TextStyle(
                fontSize: textTheme.headlineSmall!.fontSize,
              );
            case 4:
              style = TextStyle(
                fontSize: textTheme.titleLarge!.fontSize,
              );
            case 5:
              style = TextStyle(
                fontSize: textTheme.titleMedium!.fontSize,
              );
            case 6:
              style = TextStyle(
                fontSize: textTheme.titleSmall!.fontSize,
              );
          }
        }
        return style;
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
      case MarkdownElement.quote:
        return TextStyle(fontSize: fontSize);
      case MarkdownElement.strikethrough:
        return TextStyle(
          fontSize: fontSize,
          decoration: TextDecoration.lineThrough,
        );
      case MarkdownElement.subscript:
        return TextStyle(fontSize: fontSize);
      case MarkdownElement.superscript:
        return TextStyle(fontSize: fontSize);
      default:
        return TextStyle(fontSize: fontSize);
    }
  }
}
