import 'package:dial_editor/src/feature/connection/data/data_source/connection_local_data_source.dart';
import 'package:dial_editor/src/feature/connection/domain/model/connection.dart';
import 'package:dial_editor/src/feature/connection/domain/repository/connection_repository.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:sembast/sembast.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  ConnectionLocalDataSource connectionLocalDataSource;

  ConnectionRepositoryImpl(this.connectionLocalDataSource);

  @override
  Future<List<Connection>> getConnections() async {
    final db = connectionLocalDataSource.openDatabase();
    final store = StoreRef.main();
    return (await store.record("metadata").get(await db))! as List<Connection>;
  }

  @override
  Future<void> saveConnection(Node source, Node target) {
    // TODO: implement saveConnection
    throw UnimplementedError();
  }

  @override
  Future<void> deleteConnection(Node source, Node target) {
    // TODO: implement deleteConnection
    throw UnimplementedError();
  }
}
