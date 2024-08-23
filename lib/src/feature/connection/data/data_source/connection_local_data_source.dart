import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

abstract class ConnectionLocalDataSource {
  Future<Database> openDatabase();
}

class ConnectionLocalDataSourceImpl implements ConnectionLocalDataSource {
  @override
  Future<Database> openDatabase() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDir.path}/metadata.db';
    final database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }
}
