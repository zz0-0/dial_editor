import 'dart:convert';

import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/node_repository_impl.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';

class StringToDocumentConverter extends Converter<String, Document> {
  StringToDocumentConverter(this.uuid);
  final String uuid;
  @override
  Document convert(String input) {
    final NodeRepository nodeRepository = NodeRepositoryImpl();
    final lines = input.split('\n');
    final (nodeKeyList, nodeMap) = nodeRepository.convertDocument(lines);
    final document = Document(uuid: uuid)
      ..nodeKeyList = nodeKeyList
      ..nodeMap = nodeMap;
    return document;
  }
}
