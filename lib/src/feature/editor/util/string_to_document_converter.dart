import 'dart:convert';
import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code_block.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code_block_marker.dart';
// import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code_block_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code_line.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/heading.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/list/ordered_list.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/list/task_list.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/list/unordered_list.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/quote.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/bold.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/bold_italic.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/emoji.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/highlight.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/horizontal_rule.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/image.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/italic.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/link.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/strikethrough.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/subscript.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/superscript.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StringToDocumentConverter extends Converter<String, Document> {
  WidgetRef ref;
  BuildContext context;

  StringToDocumentConverter(this.ref, this.context);

  @override
  Document convert(String input) {
    final lines = input.split("\n");
    final children = <Node>[];
    String? language = "";
    bool isInCodeBlock = false;
    final GlobalKey key = GlobalKey();
    CodeBlock? block = CodeBlock(
      context: context,
      blockKey: key,
      language: language,
      children: [],
    );

    for (final line in lines) {
      if (codeBlockRegex.hasMatch(line)) {
        if (isInCodeBlock == false) {
          isInCodeBlock = true;
          final match = codeBlockRegex.firstMatch(line);
          language = match?.group(0);
          block!.children!.add(
            CodeBlockMarker(
              context: context,
              rawText: line,
              isStart: true,
              parentKey: key,
            ),
          );
        } else {
          isInCodeBlock = false;
          block!.children!.add(
            CodeBlockMarker(
              context: context,
              rawText: line,
              isStart: true,
              parentKey: key,
            ),
          );
          children.add(block);
          block = null;
        }
      } else if (isInCodeBlock) {
        block!.children!.add(
          CodeLine(
            context: context,
            language: language,
            rawText: line,
            parentKey: key,
          ),
        );
      } else {
        children.add(convertLine(line: line, isInCodeBlock: isInCodeBlock));
      }
    }
    return Document(children: children);
  }

  Node convertLine({
    required String line,
    required bool isInCodeBlock,
    String? language,
    GlobalKey? key,
  }) {
    if (isInCodeBlock) {
      if (codeBlockRegex.hasMatch(line)) {
        return CodeBlockMarker(
          context: context,
          rawText: line,
          isStart: true,
          parentKey: key!,
        );
      } else {
        return CodeLine(
          context: context,
          language: language,
          rawText: line,
          parentKey: key!,
        );
      }
    } else {
      if (line.startsWith('>')) {
        return Quote(context: context, rawText: line);
      } else if (taskListRegex.hasMatch(line)) {
        return TaskList(context: context, rawText: line);
      } else if (orderListRegex.hasMatch(line)) {
        return OrderedList(context: context, rawText: line);
      } else if (unorderedListRegex.hasMatch(line)) {
        return UnorderedList(context: context, rawText: line);
      } else if (line.startsWith('#')) {
        int level = 0;
        while (line[level] == '#') {
          level++;
        }
        return Heading(context: context, level: level, rawText: line);
      } else if (boldItalicRegex.hasMatch(line)) {
        return BoldItalic(context: context, rawText: line);
      } else if (boldRegex.hasMatch(line)) {
        return Bold(context: context, rawText: line);
      } else if (italicRegex.hasMatch(line)) {
        return Italic(context: context, rawText: line);
      } else if (highlightRegex.hasMatch(line)) {
        return Highlight(context: context, rawText: line);
      } else if (strikethroughRegex.hasMatch(line)) {
        return Strikethrough(context: context, rawText: line);
      } else if (imageRegex.hasMatch(line) || imageUrlRegex.hasMatch(line)) {
        return ImageNode(context: context, rawText: line);
      } else if (linkRegex.hasMatch(line) || urlRegex.hasMatch(line)) {
        return Link(context: context, rawText: line);
      } else if (subscriptRegex.hasMatch(line)) {
        return Subscript(context: context, rawText: line);
      } else if (superscriptRegex.hasMatch(line)) {
        return Superscript(context: context, rawText: line);
      } else if (horizontalRuleRegex.hasMatch(line)) {
        return HorizontalRule(context: context, rawText: line);
      } else if (emojiRegex.hasMatch(line)) {
        return EmojiNode(context: context, rawText: line);
      } else {
        return TextNode(context: context, rawText: line);
      }
    }
  }
}
