import 'dart:convert';
import 'package:dial_editor/src/core/markdown_element.dart';

class DocumentToStringConverter extends Converter<Document, String> {
  @override
  String convert(Document input) {
    return input.toString();
  }
}
