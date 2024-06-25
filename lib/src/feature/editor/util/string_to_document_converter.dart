import 'dart:convert';

import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/util/markdown_parser.dart';

class StringToDocumentConverter extends Converter<String, Document> {
  @override
  Document convert(String input) {
    final lines = input.split("\n");
    final children = lines.map((e) {
      final node = MarkdownParser().parseMarkdownLine(e);
      return node;
    }).toList();

    return Document(children: children);
  }
}
