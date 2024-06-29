import 'dart:convert';

import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/bold.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/code.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/heading.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/image.dart'
    as dial;
import 'package:dial_editor/src/feature/editor/domain/entity/element/italic.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/link.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/list/ordered_list.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/list/unordered_list.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/quote.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/strikethrough.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class StringToDocumentConverter extends Converter<String, Document> {
  BuildContext context;

  StringToDocumentConverter(this.context);

  @override
  Document convert(String input) {
    final lines = input.split("\n");

    final children = <Node>[];

    bool isInCodeBlock = false;
    List<String> codeBlockLines = [];

    for (final line in lines) {
      if (line.startsWith('```')) {
        isInCodeBlock = !isInCodeBlock;
        if (!isInCodeBlock) {
          children.add(Code(context, codeBlockLines.join('\n')));
          codeBlockLines = [];
        }
        continue;
      }

      if (isInCodeBlock) {
        codeBlockLines.add(line);
        continue;
      }

      if (line.startsWith('>')) {
        children.add(Quote(context, line.substring(1).trim()));
      } else if (RegExp(r'^\d+\.\s').hasMatch(line)) {
        children.add(OrderedList(context, line.substring(2).trim()));
      } else if (line.startsWith('- ') || line.startsWith('* ')) {
        children.add(UnorderedList(context, line.substring(2).trim()));
      } else if (line.startsWith('#')) {
        int level = 0;
        while (line[level] == '#') {
          level++;
        }
        children.add(
          Heading(context, level, line),
        );
      } else if (RegExp(r'\*\*(.*?)\*\*').hasMatch(line) ||
          RegExp('__(.*?)__').hasMatch(line)) {
        children.add(Bold(context, line));
      } else if (RegExp(r'\*(.*?)\*').hasMatch(line) ||
          RegExp('_(.*?)_').hasMatch(line)) {
        children.add(Italic(context, line));
      } else if (RegExp('~~(.*?)~~').hasMatch(line)) {
        children.add(Strikethrough(context, line));
      } else if (RegExp(r'!\[(.*?)\]\((.*?)\)').hasMatch(line)) {
        final match = RegExp(r'!\[(.*?)\]\((.*?)\)').firstMatch(line);
        children.add(
            dial.Image(context, match?.group(1) ?? '', match?.group(2) ?? ''));
      } else if (RegExp(r'\[(.*?)\]\((.*?)\)').hasMatch(line)) {
        final match = RegExp(r'\[(.*?)\]\((.*?)\)').firstMatch(line);
        children
            .add(Link(context, match?.group(1) ?? '', match?.group(2) ?? ''));
      } else {
        children.add(TextNode(context, line));
      }
    }

    return Document(children: children);
  }
}
