import 'dart:io';

import 'package:dial_editor/src/feature/editor/data/data_source/database_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/data_source/file_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/document_codec.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';
import 'package:sembast/sembast.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final FileLocalDataSource fileLocalDataSource;
  final DatabaseLocalDataSource databaseLocalDataSource;

  DocumentRepositoryImpl({
    required this.fileLocalDataSource,
    required this.databaseLocalDataSource,
  });

  @override
  Future<Document> getDocumentFromDatabase() async {
    final db = databaseLocalDataSource.openDatabase();
    final store = StoreRef.main();
    return (await store.record("document").get(await db))! as Document;
  }

  @override
  Future<void> saveDocumentToDatabase(
    Document document,
  ) async {
    final db = databaseLocalDataSource.openDatabase();
    final store = StoreRef.main();
    await store.record("document").put(await db, document);
  }

  @override
  String decode(Document input) {
    final String content = DocumentCodec().decode(input);
    return content;
  }

  @override
  Document encode() {
    final File file = fileLocalDataSource.getFile();
    final String input = file.readAsStringSync();
    return DocumentCodec().encode(input);
  }

  @override
  void saveDocumentToFile(String input) {
    fileLocalDataSource.saveFile(input);
  }
}
