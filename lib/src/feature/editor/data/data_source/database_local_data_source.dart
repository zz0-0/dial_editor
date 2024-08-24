import 'dart:io';

import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

abstract class DatabaseLocalDataSource {
  Future<Database> openDatabase();
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
}
