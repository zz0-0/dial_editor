import 'dart:io';

import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
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
  Future<List<Document>> fetchAllDocuments();
  Future<FileMetadata> fetchFileMetadata(String uuid);
  Future<void> saveDocument(Document document);
  Future<void> deleteDocument(String uuid);
  Future<void> updateFilePath(String uuid, String filePath);
  Future<void> saveChunk(Document document, Node oldNode, Node newNode);
}

class DatabaseLocalDataSourceImpl implements DatabaseLocalDataSource {
  Ref ref;
  late Database _databaseMetadata;
  late Database _databaseDocument;

  DatabaseLocalDataSourceImpl._create(this.ref);

  static Future<DatabaseLocalDataSourceImpl> create(Ref ref) async {
    final instance = DatabaseLocalDataSourceImpl._create(ref);
    await instance._initializeDatabases();
    return instance;
  }

  Future<void> _initializeDatabases() async {
    _databaseMetadata = await openDatabaseMetadata();
    _databaseDocument = await openDatabaseDocument();
  }

  @override
  Future<Database> openDatabaseMetadata() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDir.path}/metadata.db';
    return _databaseMetadata =
        await databaseFactoryIo.openDatabase(dbPath, mode: DatabaseMode.create);
  }

  @override
  Future<Database> openDatabaseDocument() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDir.path}/document.db';
    return _databaseDocument =
        await databaseFactoryIo.openDatabase(dbPath, mode: DatabaseMode.create);
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
            fileMetadata.toMap(),
          );
      return (uuid, false);
    }
  }

  Future<FileMetadata> _getFileMetadata(File file) async {
    final stat = await file.stat();
    return FileMetadata(
      size: stat.size,
      path: file.path,
      name: file.path.split(Platform.pathSeparator).last,
      created: stat.changed.toIso8601String(),
      modified: stat.modified.toIso8601String(),
    );
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
  Future<List<Document>> fetchAllDocuments() async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    final recordSnapshot = await store.find(_databaseDocument);
    return recordSnapshot.map((e) => Document.fromMap(e.value)).toList();
  }

  @override
  Future<FileMetadata> fetchFileMetadata(String uuid) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    final recordSnapshot = await store.record(uuid).get(_databaseMetadata);

    if (recordSnapshot != null) {
      return FileMetadata.fromMap(recordSnapshot);
    } else {
      throw Exception('File Metadata not found');
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

  @override
  Future<void> saveChunk(Document document, Node oldNode, Node newNode) async {
    // final store = StoreRef<String, Map<String, dynamic>>.main();
    // final existingRecord =
    //     await store.record(document.uuid).get(_databaseMetadata);
  }
}
