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

  DatabaseLocalDataSourceImpl(this.ref);

  @override
  Future<Database> openDatabase() async {
    final File file = ref.read(fileProvider)!;
    final String fileName = file.path.split('/').last;
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDir.path}/$fileName.db';
    final database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }

  @override
  Future<void> deleteDocument() {
    // TODO: implement deleteDocument
    throw UnimplementedError();
  }

  @override
  Future<Document> fetchDocument() {
    // TODO: implement fetchDocument
    throw UnimplementedError();
  }

  @override
  Future<void> saveDocument(Document document) {
    // TODO: implement saveDocument
    throw UnimplementedError();
  }
}
