import 'dart:convert';

import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';

class StringToDocumentConverter extends Converter<String, Document> {
  @override
  Document convert(String input) {
    final lines = input.split("\n");
    final children = lines.map((e) {
      // Node node;

      // node.text = e;
      // node.tag = "h1";

      // return node;
    }).toList();

    return Document(children: children);
  }
}
