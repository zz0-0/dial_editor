import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';

abstract class ConnectionRepository {
  Future<List<Connection>> getConnections();
  Future<void> saveConnection(Node source, Node target);
  Future<void> deleteConnection(Node source, Node target);
}
