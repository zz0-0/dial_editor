import 'package:dial_editor/src/feature/editor/data/data_source/database_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/connection_repository.dart';
import 'package:sembast/sembast.dart';

/// Implementation of the [ConnectionRepository] interface.
///
/// This class provides the concrete implementation for the methods defined
/// in the [ConnectionRepository] interface, handling the data operations
/// related to connections.
class ConnectionRepositoryImpl implements ConnectionRepository {
  /// Implementation of the ConnectionRepository interface.
  ///
  /// This class is responsible for managing the connection-related data
  /// using the provided local data source.
  ///
  /// The [databaseLocalDataSource] parameter is required to interact with
  /// the local database for connection data operations.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// final connectionRepository = 
  /// ConnectionRepositoryImpl(databaseLocalDataSource);
  /// ```
  ConnectionRepositoryImpl(this.databaseLocalDataSource);

  /// A data source for accessing local database operations.
  ///
  /// This is used to interact with the local database to perform
  /// CRUD operations and other database-related tasks.
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
