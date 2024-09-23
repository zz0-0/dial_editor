/// Represents a connection within the editor domain.
/// 
/// This class is used to model the connections between different
/// components or nodes in the editor. It contains the necessary
/// properties and methods to manage and manipulate these connections.
class Connection {
  /// Represents a connection within the editor domain model.
  /// 
  /// This class is used to define the properties and behavior of a connection
  /// between different elements in the editor.
  /// 
  /// Example usage:
  /// 
  /// ```dart
  /// Connection(
  ///   // initialization parameters
  /// );
  /// ```
  /// 
  /// Properties:
  /// - Add a list of properties here with descriptions.
  /// 
  /// Methods:
  /// - Add a list of methods here with descriptions.
  Connection({
    required this.sourceDocumentUuid,
    required this.targetDocumentUuid,
    required this.connectionKey,
    required this.sourceNodeKey,
    required this.targetNodeKey,
  });
  /// The UUID of the source document that this connection is associated with.
  String sourceDocumentUuid;
  /// The UUID of the target document that this connection points to.
  String targetDocumentUuid;
  /// A unique key representing the connection.
  /// This key is used to identify and manage connections within the system.
  String connectionKey;
  /// The key that uniquely identifies the source node in a connection.
  String sourceNodeKey;
  /// The key of the target node to which this connection is linked.
  String targetNodeKey;
}
