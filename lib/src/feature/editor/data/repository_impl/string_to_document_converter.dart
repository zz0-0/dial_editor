import 'dart:convert';

import 'package:dial_editor/src/feature/editor/data/repository_impl/node_repository_impl.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';
import 'package:flutter/material.dart';

class StringToDocumentConverter extends Converter<String, Document> {
  @override
  Document convert(String input) {
    final NodeRepository nodeRepository = NodeRepositoryImpl();
    final lines = input.split("\n");
    final (nodeKeyList, nodeMap) = nodeRepository.convertDocument(lines);
    final document = Document(key: GlobalKey());
    document.nodeKeyList = nodeKeyList;
    document.nodeMap = nodeMap;
    return document;
  }
}
