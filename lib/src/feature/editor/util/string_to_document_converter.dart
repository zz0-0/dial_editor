import 'dart:convert';
import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code/code_block.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code/code_block_marker.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code/code_block_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code/code_line.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/heading.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/list/ordered_list.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/list/task_list.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/list/unordered_list.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/bold.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/bold_italic.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/emoji.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/highlight.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/horizontal_rule.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/image.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/italic.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/link.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/math.dart';
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
  Heading? currentHeading;
  CodeBlock? currentCodeBlock;
  bool isInCodeBlock = false;

  StringToDocumentConverter(this.ref, this.context);

  @override
  Document convert(String input) {
    final lines = input.split("\n");
    final children = <Node>[];
    final GlobalKey key = GlobalKey();

    for (final line in lines) {
      blockMatch(line, key, children);
    }

    if (currentHeading != null) {
      children.add(currentHeading!);
    }

    return Document(children: children);
  }

  void blockMatch(
    String line,
    GlobalKey<State<StatefulWidget>> key,
    List<Node> children,
  ) {
    if (line.startsWith("#")) {
      if (currentHeading != null) {
        children.add(currentHeading!);
      }
      currentHeading = createHeading(line, key);
    } else if (codeBlockRegex.hasMatch(line)) {
      if (isInCodeBlock == false) {
        isInCodeBlock = true;
        final match = codeBlockRegex.firstMatch(line);
        final String language = match!.groupCount >= 1 && match.group(1) != null
            ? match.group(1)!
            : 'c';
        currentCodeBlock = CodeBlock(
          context: context,
          language: language,
          children: [],
          blockKey: GlobalKey(),
          parentKey: currentHeading?.blockKey ?? key,
        );
        currentCodeBlock!.children!.add(
          CodeBlockMarker(
            context: context,
            rawText: line,
            isStart: true,
            parentKey: currentCodeBlock!.key,
          ),
        );
      } else {
        isInCodeBlock = false;
        currentCodeBlock!.children!.add(
          CodeBlockMarker(
            context: context,
            rawText: line,
            isStart: false,
            parentKey: currentCodeBlock!.key,
          ),
        );
        if (currentHeading != null) {
          currentHeading!.children!.add(currentCodeBlock!);
        } else {
          children.add(currentCodeBlock!);
        }
        currentCodeBlock = null;
      }
    } else if (isInCodeBlock == true) {
      currentCodeBlock!.children!.add(
        CodeLine(
          context: context,
          language: currentCodeBlock!.language,
          rawText: line,
          parentKey: currentCodeBlock!.key,
        ),
      );
    } else {
      final Node lineNode =
          convertLine(line: line, isInCodeBlock: isInCodeBlock);
      if (currentHeading != null) {
        currentHeading!.children!.add(lineNode);
      } else {
        children.add(lineNode);
      }
    }
  }

  Heading? createHeading(String line, [GlobalKey? parentKey]) {
    int level = 0;

    while (level < line.length && line[level] == '#') {
      level++;
    }

    return Heading(
      context: context,
      level: level,
      rawText: line,
      children: [],
      parentKey: parentKey,
      blockKey: GlobalKey(),
    );
  }

  Node convertLine({
    required String line,
    required bool isInCodeBlock,
    String? language,
    GlobalKey? parentKey,
    GlobalKey? blockKey,
    int? index,
  }) {
    if (isInCodeBlock) {
      if (codeBlockRegex.hasMatch(line)) {
        ref
            .read(
              codeBlockNotifierProvider(
                parentKey!,
              ).notifier,
            )
            .updateLine(index!, line);
        return CodeBlockMarker(
          context: context,
          rawText: line,
          isStart: true,
          parentKey: parentKey,
        );
      } else {
        ref
            .read(
              codeBlockNotifierProvider(
                parentKey!,
              ).notifier,
            )
            .updateLine(index!, line);
        return CodeLine(
          context: context,
          language: language,
          rawText: line,
          parentKey: parentKey,
        );
      }
    } else {
      // if (line.startsWith('>')) {
      //   return Quote(
      //     context: context,
      //     rawText: line,
      //     blockKey: null,
      //     parentKey: parentKey,
      //   );
      // }
      // else
      if (taskListRegex.hasMatch(line)) {
        return TaskList(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (orderListRegex.hasMatch(line)) {
        return OrderedList(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (unorderedListRegex.hasMatch(line)) {
        return UnorderedList(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (line.startsWith('#')) {
        int level = 0;
        while (line[level] == '#') {
          level++;
        }
        return Heading(
          context: context,
          level: level,
          rawText: line,
          parentKey: parentKey,
          blockKey: blockKey ?? GlobalKey(),
        );
      } else if (inlineMathRegex.hasMatch(line)) {
        return Math(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (boldItalicRegex.hasMatch(line)) {
        return BoldItalic(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (boldRegex.hasMatch(line)) {
        return Bold(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (italicRegex.hasMatch(line)) {
        return Italic(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (highlightRegex.hasMatch(line)) {
        return Highlight(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (strikethroughRegex.hasMatch(line)) {
        return Strikethrough(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (imageRegex.hasMatch(line) || imageUrlRegex.hasMatch(line)) {
        return ImageNode(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (linkRegex.hasMatch(line) || urlRegex.hasMatch(line)) {
        return Link(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (subscriptRegex.hasMatch(line)) {
        return Subscript(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (superscriptRegex.hasMatch(line)) {
        return Superscript(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (horizontalRuleRegex.hasMatch(line)) {
        return HorizontalRule(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else if (emojiRegex.hasMatch(line)) {
        return EmojiNode(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      } else {
        return TextNode(
          context: context,
          rawText: line,
          parentKey: parentKey,
        );
      }
    }
  }
}
