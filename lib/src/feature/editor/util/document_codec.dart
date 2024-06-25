import 'dart:convert';

import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/util/document_to_string_converter.dart';
import 'package:dial_editor/src/feature/editor/util/string_to_document_converter.dart';

class DocumentCodec extends Codec<String, Document> {
  @override
  Converter<Document, String> get decoder => DocumentToStringConverter();

  @override
  Converter<String, Document> get encoder => StringToDocumentConverter();
}
