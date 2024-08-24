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
  String decode(Document input) {
    final String content = DocumentCodec().decode(input);
    return content;
  }

  @override
  Document encode() {
    final File file = fileLocalDataSource.readFile();
    final String input = file.readAsStringSync();
    return DocumentCodec().encode(input);
  }

  @override
  void saveDocumentToFile(String input) {
    fileLocalDataSource.writeFile(input);
  }

  @override
  Future<Document> fetchDocumentFromDatabase() {
    // TODO: implement fetchDocumentFromDatabase
    throw UnimplementedError();
  }

  @override
  Future<void> saveDocumentToDatabase(Document input) {
    // TODO: implement saveDocumentToDatabase
    throw UnimplementedError();
  }
}
