import 'dart:convert';

import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/bold.dart';
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

    for (final line in lines) {
      children.add(convertLine(line));
    }

    return Document(children: children);
  }

  Node convertLine(String line) {
    // bool isInCodeBlock = false;
    // List<String> codeBlockLines = [];

    // if (line.startsWith('```')) {
    //     isInCodeBlock = !isInCodeBlock;
    //     if (!isInCodeBlock) {
    //       return (Code(context, codeBlockLines.join('\n')));
    //       codeBlockLines = [];
    //     }
    //     continue;
    //   }

    //   if (isInCodeBlock) {
    //     codeBlockLines.add(line);
    //     continue;
    //   }

    if (line.startsWith('>')) {
      return Quote(context, line.substring(1).trim());
    } else if (RegExp(r'^\d+\.\s').hasMatch(line)) {
      return OrderedList(context, line.substring(2).trim());
    } else if (line.startsWith('- ') || line.startsWith('* ')) {
      return UnorderedList(context, line.substring(2).trim());
    } else if (line.startsWith('#')) {
      int level = 0;
      while (line[level] == '#') {
        level++;
      }
      return Heading(context, level, line);
    } else if (RegExp(r'\*\*(.*?)\*\*').hasMatch(line) ||
        RegExp('__(.*?)__').hasMatch(line)) {
      return Bold(context, line);
    } else if (RegExp(r'\*(.*?)\*').hasMatch(line) ||
        RegExp('_(.*?)_').hasMatch(line)) {
      return Italic(context, line);
    } else if (RegExp('~~(.*?)~~').hasMatch(line)) {
      return Strikethrough(context, line);
    } else if (RegExp(r'!\[(.*?)\]\((.*?)\)').hasMatch(line)) {
      final match = RegExp(r'!\[(.*?)\]\((.*?)\)').firstMatch(line);
      return dial.Image(context, match?.group(1) ?? '', match?.group(2) ?? '');
    } else if (RegExp(r'\[(.*?)\]\((.*?)\)').hasMatch(line)) {
      final match = RegExp(r'\[(.*?)\]\((.*?)\)').firstMatch(line);
      return Link(context, match?.group(1) ?? '', match?.group(2) ?? '');
    } else {
      return TextNode(context, line);
    }
  }
}
