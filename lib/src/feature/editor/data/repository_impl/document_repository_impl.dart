import 'dart:io';

import 'package:dial_editor/src/feature/editor/data/data_source/database_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/data_source/file_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/document_codec.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';
import 'package:flutter/material.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final FileLocalDataSource fileLocalDataSource;
  final DatabaseLocalDataSource databaseLocalDataSource;

  DocumentRepositoryImpl({
    required this.fileLocalDataSource,
    required this.databaseLocalDataSource,
  });

  @override
  Future<String> decode(Document input) async {
    final String content = DocumentCodec().decode(input);
    return content;
  }

  @override
  Future<Document> encode() {
    final Future<File> file = fileLocalDataSource.readFile();
    return file.then((value) {
      final String input = value.readAsStringSync();
      return DocumentCodec().encode(input);
    });
  }

  @override
  Future<void> saveDocumentToFile(String input) {
    return fileLocalDataSource.writeFile(input);
  }

  @override
  Future<Document> fetchDocumentFromDatabase(GlobalKey key) async {
    return databaseLocalDataSource.fetchDocument(key);
  }

  @override
  Future<void> saveDocumentToDatabase(Document input) {
    return databaseLocalDataSource.saveDocument(input);
  }
}
