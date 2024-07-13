import 'dart:convert';
import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/bold.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/bold_italic.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code_block_marker.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code_line.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/emoji.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/heading.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/highlight.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/horizontal_rule.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/image.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/italic.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/link.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/list/ordered_list.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/list/task_list.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/list/unordered_list.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/quote.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/strikethrough.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/subscript.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/superscript.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';

class StringToDocumentConverter extends Converter<String, Document> {
  BuildContext context;

  StringToDocumentConverter(this.context);

  @override
  Document convert(String input) {
    final lines = input.split("\n");
    final children = <Node>[];
    String language = "";
    bool isInCodeBlock = false;

    for (final line in lines) {
      if (codeBlockRegex.hasMatch(line)) {
        if (isInCodeBlock == false) {
          isInCodeBlock = true;
          final match = codeBlockRegex.firstMatch(line);
          language = match!.group(1) ?? '';
          children.add(CodeBlockMarker(context, language, true));
        } else {
          isInCodeBlock = false;
          children.add(CodeBlockMarker(context, language, false));
        }
      } else {
        children.add(convertLine(line, isInCodeBlock));
      }
    }

    return Document(children: children);
  }

  Node convertLine(String line, bool isInCodeBlock) {
    if (isInCodeBlock) {
      return CodeLine(context, line);
    }

    if (line.startsWith('>')) {
      return Quote(context, line);
    } else if (taskListRegex.hasMatch(line)) {
      return TaskList(context, line);
    } else if (orderListRegex.hasMatch(line)) {
      return OrderedList(context, line);
    } else if (unorderedListRegex.hasMatch(line)) {
      return UnorderedList(context, line);
    } else if (line.startsWith('#')) {
      int level = 0;
      while (line[level] == '#') {
        level++;
      }
      return Heading(context, level, line);
    } else if (boldItalicRegex.hasMatch(line)) {
      return BoldItalic(context, line);
    } else if (boldRegex.hasMatch(line)) {
      return Bold(context, line);
    } else if (italicRegex.hasMatch(line)) {
      return Italic(context, line);
    } else if (highlightRegex.hasMatch(line)) {
      return Highlight(context, line);
    } else if (strikethroughRegex.hasMatch(line)) {
      return Strikethrough(context, line);
    } else if (imageRegex.hasMatch(line) || imageUrlRegex.hasMatch(line)) {
      return ImageNode(context, line);
    } else if (linkRegex.hasMatch(line) || urlRegex.hasMatch(line)) {
      return Link(context, line);
    } else if (subscriptRegex.hasMatch(line)) {
      return Subscript(context, line);
    } else if (superscriptRegex.hasMatch(line)) {
      return Superscript(context, line);
    } else if (horizontalRuleRegex.hasMatch(line)) {
      return HorizontalRule(context, line);
    } else if (emojiRegex.hasMatch(line)) {
      return EmojiNode(context, line);
    } else {
      return TextNode(context, line);
    }
  }
}
