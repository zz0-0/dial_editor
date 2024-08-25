import 'dart:io';

import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/document.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

abstract class DatabaseLocalDataSource {
  Future<Database> openDatabase();
  Future<Document> fetchDocument();
  Future<void> saveDocument(Document document);
  Future<void> deleteDocument();
}

class DatabaseLocalDataSourceImpl implements DatabaseLocalDataSource {
  Ref ref;
  late Database _database;

  DatabaseLocalDataSourceImpl(this.ref);

  @override
  Future<Database> openDatabase() async {
    final File file = ref.read(fileProvider)!;
    final String fileName = file.path.split('/').last;
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDir.path}/$fileName.db';
    return _database = await databaseFactoryIo.openDatabase(dbPath);
  }

  @override
  Future<Document> fetchDocument() async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    final recordSnapshot = await store.record('document').get(_database);

    if (recordSnapshot != null) {
      return Document.fromMap(recordSnapshot);
    } else {
      throw Exception('Document not found');
    }
  }

  @override
  Future<void> saveDocument(Document document) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    await store.record('document').put(_database, document.toMap());
  }

  @override
  Future<void> deleteDocument() async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    await store.record('document').delete(_database);
  }
}
