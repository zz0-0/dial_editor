import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

abstract class DocumentRepository {
  Future<Document> encode();
  Future<String> decode(Document input);
  Future<void> saveDocumentToFile(String input);
  Future<Document> fetchDocumentFromDatabase(GlobalKey key);
  Future<void> saveDocumentToDatabase(Document input);
}
