import 'dart:convert';
import 'package:dial_editor/src/feature/editor/domain/model/document.dart';
import 'package:dial_editor/src/feature/editor/util/document_to_string_converter.dart';
import 'package:dial_editor/src/feature/editor/util/string_to_document_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentCodec extends Codec<String, Document> {
  WidgetRef ref;
  BuildContext context;

  DocumentCodec(this.ref, this.context);

  @override
  Converter<Document, String> get decoder => DocumentToStringConverter();

  @override
  Converter<String, Document> get encoder =>
      StringToDocumentConverter(ref, context);
}
