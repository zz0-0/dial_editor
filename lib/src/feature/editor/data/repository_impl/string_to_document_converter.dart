import 'dart:convert';

import 'package:dial_editor/src/feature/editor/data/repository_impl/node_repository_impl.dart';
import 'package:dial_editor/src/feature/editor/domain/model/document.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';

class StringToDocumentConverter extends Converter<String, Document> {
  @override
  Document convert(String input) {
    final NodeRepository nodeRepository = NodeRepositoryImpl();
    final lines = input.split("\n");

    return Document(children: nodeRepository.convertDocument(lines));
  }
}
