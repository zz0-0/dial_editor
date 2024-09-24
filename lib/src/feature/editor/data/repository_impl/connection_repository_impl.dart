import 'package:dial_editor/src/feature/editor/data/data_source/database_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/connection_repository.dart';
import 'package:sembast/sembast.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  ConnectionRepositoryImpl(this.databaseLocalDataSource);
  final DatabaseLocalDataSource databaseLocalDataSource;
  @override
  Future<List<Connection>> getConnections() async {
    final db = databaseLocalDataSource.openDatabaseDocument();
    final store = StoreRef.main();
    return (await store.record('connection').get(await db))!
        as List<Connection>;
  }

  @override
  Future<void> saveConnection(Node source, Node target) {
    // TODO(source): implement saveConnection
    throw UnimplementedError();
  }

  @override
  Future<void> deleteConnection(Node source, Node target) {
    // TODO(source): implement deleteConnection
    throw UnimplementedError();
  }
}
