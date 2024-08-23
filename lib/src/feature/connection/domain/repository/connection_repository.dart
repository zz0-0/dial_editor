import 'package:dial_editor/src/feature/connection/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';

abstract class ConnectionRepository {
  Future<List<Connection>> getConnections();

  saveConnection(Node source, Node target) {}

  deleteConnection(Node source, Node target) {}
}
