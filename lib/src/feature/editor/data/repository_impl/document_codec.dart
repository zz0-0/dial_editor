import 'dart:convert';

import 'package:dial_editor/src/feature/editor/data/repository_impl/document_to_string_converter.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/string_to_document_converter.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

class DocumentCodec extends Codec<String, Document> {
  DocumentCodec();

  @override
  Converter<Document, String> get decoder => DocumentToStringConverter();

  @override
  Converter<String, Document> get encoder => StringToDocumentConverter();
}
