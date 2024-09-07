import 'dart:io';

import 'package:dial_editor/src/feature/editor/domain/model/document.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:uuid/uuid.dart';

abstract class DatabaseLocalDataSource {
  Future<Database> openDatabaseMetadata();
  Future<Database> openDatabaseDocument();
  Future<(String, bool)> getOrCreateUuidForFile(File file);
  Future<Document> fetchDocument(String uuid);
  Future<void> saveDocument(Document document);
  Future<void> deleteDocument(String uuid);
  Future<void> updateFilePath(String uuid, String filePath);
}

class DatabaseLocalDataSourceImpl implements DatabaseLocalDataSource {
  Ref ref;
  late Database _databaseMetadata;
  late Database _databaseDocument;

  DatabaseLocalDataSourceImpl(this.ref) {
    openDatabaseMetadata();
    openDatabaseDocument();
  }

  @override
  Future<Database> openDatabaseMetadata() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDir.path}/metadata.db';
    return _databaseMetadata = await databaseFactoryIo.openDatabase(dbPath);
  }

  @override
  Future<Database> openDatabaseDocument() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDir.path}/document.db';
    return _databaseDocument = await databaseFactoryIo.openDatabase(dbPath);
  }

  @override
  Future<(String, bool)> getOrCreateUuidForFile(File file) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    final result = await store.find(
      _databaseMetadata,
      finder: Finder(filter: Filter.equals('filePath', file.path)),
    );
    if (result.isNotEmpty) {
      return (result.first.key, true);
    } else {
      final uuid = const Uuid().v4();
      final fileMetadata = await _getFileMetadata(file);
      await store.record(uuid).put(
        _databaseMetadata,
        {'filePath': file.path, 'metadata': fileMetadata},
      );
      return (uuid, false);
    }
  }

  Future<Map<String, dynamic>> _getFileMetadata(File file) async {
    final stat = await file.stat();
    return {
      'size': stat.size,
      'created': stat.changed.toIso8601String(),
      'modified': stat.modified.toIso8601String(),
    };
  }

  @override
  Future<Document> fetchDocument(String uuid) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    final recordSnapshot = await store.record(uuid).get(_databaseDocument);

    if (recordSnapshot != null) {
      return Document.fromMap(recordSnapshot);
    } else {
      throw Exception('Document not found');
    }
  }

  @override
  Future<void> saveDocument(Document document) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    await store.record(document.uuid).put(_databaseDocument, document.toMap());
  }

  @override
  Future<void> deleteDocument(String uuid) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    await store.record(uuid).delete(_databaseDocument);
  }

  @override
  Future<void> updateFilePath(String uuid, String filePath) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    final existingRecord = await store.record(uuid).get(_databaseMetadata);

    if (existingRecord != null) {
      existingRecord['filePath'] = filePath;
      await store.record(uuid).put(_databaseMetadata, existingRecord);
    }
  }
}
