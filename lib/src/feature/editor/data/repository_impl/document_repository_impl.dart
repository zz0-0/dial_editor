import 'dart:io';

import 'package:dial_editor/src/feature/editor/data/data_source/database_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/data_source/file_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/document_codec.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final FileLocalDataSource fileLocalDataSource;
  final DatabaseLocalDataSource databaseLocalDataSource;

  DocumentRepositoryImpl({
    required this.fileLocalDataSource,
    required this.databaseLocalDataSource,
  });

  @override
  Future<String> decode(Document input) async {
    final String content = DocumentCodec(input.uuid).decode(input);
    return content;
  }

  @override
  Future<Document> encode() {
    final Future<File> file = fileLocalDataSource.readFile();

    return file.then((value) {
      final Future<(String, bool)> uuid =
          databaseLocalDataSource.getOrCreateUuidForFile(value);
      return uuid.then((value2) {
        if (value2.$2) {
          return databaseLocalDataSource.fetchDocument(value2.$1);
        } else {
          final String input = value.readAsStringSync();
          final document = DocumentCodec(value2.$1).encode(input);
          databaseLocalDataSource.saveDocument(document);
          return document;
        }
      });
    });
  }

  @override
  Future<void> saveDocumentToFile(String input) {
    return fileLocalDataSource.writeFile(input);
  }

  @override
  Future<Document> fetchDocumentFromDatabase(String uuid) async {
    return databaseLocalDataSource.fetchDocument(uuid);
  }

  @override
  Future<void> saveDocumentToDatabase(Document input) {
    return databaseLocalDataSource.saveDocument(input);
  }
}
