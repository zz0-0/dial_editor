import 'dart:convert';

import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';

class DocumentToStringConverter extends Converter<Document, String> {
  @override
  String convert(Document document) {
    return document.children.map((e) {
      return "${e.text}\n";
    }).toString();
  }
}
