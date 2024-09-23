import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';

/// An abstract class that defines the contract for a connection repository.
///
/// This repository is responsible for managing connections within the
/// application.
/// Implementations of this repository should provide the necessary methods to
/// handle connection-related operations.
abstract class ConnectionRepository {
  /// Retrieves a list of connections.
  ///
  /// This method fetches and returns a list of [Connection] objects.
  ///
  /// Returns:
  ///   A [Future] that completes with a list of [Connection] instances.
  Future<List<Connection>> getConnections();

  /// Saves the connection between the source node and the target node.
  ///
  /// This method establishes a connection from the [source] node to the
  /// [target] node.
  ///
  /// [source] - The node from which the connection originates.
  /// [target] - The node to which the connection is directed.
  ///
  /// Returns a [Future] that completes when the connection is successfully
  /// saved.
  Future<void> saveConnection(Node source, Node target);

  /// Deletes the connection between the specified source and target nodes.
  ///
  /// This method removes the connection from the source node to the target node
  /// in the repository.
  ///
  /// [source] The source node from which the connection originates.
  /// [target] The target node to which the connection is directed.
  ///
  /// Throws an exception if the connection cannot be deleted.
  Future<void> deleteConnection(Node source, Node target);
}
