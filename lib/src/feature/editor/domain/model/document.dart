import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// Represents a document in the editor domain.
///
/// This class is used to model the structure and behavior of a document
/// within the editor feature of the application. It encapsulates the
/// properties and methods necessary for document manipulation and
/// management.
class Document {
  /// A class representing a document with a unique identifier.
  ///
  /// The [Document] class is used to create instances of documents
  /// that are identified by a universally unique identifier (UUID).
  ///
  /// Example usage:
  /// ```dart
  /// final document = Document(uuid: '123e4567-e89b-12d3-a456-426614174000');
  /// ```
  ///
  /// Properties:
  /// - `uuid`: A required string that represents the unique identifier of the
  /// document.
  Document({required this.uuid});

  /// Creates a new instance of [Document] from a given map.
  ///
  /// The [map] parameter is a `Map<String, dynamic>` that contains the
  /// key-value
  /// pairs representing the properties of the [Document].
  ///
  /// Returns a [Document] object populated with the data from the map.
  factory Document.fromMap(Map<String, dynamic> map) {
    final document = Document(uuid: map['uuid'] as String);
    (map['nodeMap'] as Map<String, dynamic>).forEach((key, value) {
      document.addNode(Node.fromMap(value as Map<String, dynamic>));
    });

    return document;
  }

  /// A unique identifier for the document.
  ///
  /// This UUID (Universally Unique Identifier) is used to uniquely
  /// identify each document instance within the application.
  String uuid;

  /// The type of the Markdown element, initialized to the type of a document
  /// element.
  /// This is used to specify the kind of Markdown element being dealt with.
  String type = MarkdownElement.document.type;

  /// A list of keys representing nodes in the document.
  ///
  /// This list is used to keep track of the unique identifiers for each node
  /// within the document structure.
  List<String> nodeKeyList = [];

  /// A map that associates string keys with `Node` objects.
  ///
  /// This map is used to store and manage nodes within the document,
  /// allowing for efficient retrieval and manipulation of nodes by their keys.
  Map<String, Node> nodeMap = {};

  /// Adds a [Node] to the document.
  ///
  /// This method takes a [Node] object as a parameter and adds it to the
  /// document. The specific behavior of how the node is added (e.g., at the
  /// end, at a specific position) depends on the implementation details
  /// within this method.
  ///
  /// - Parameter node: The [Node] object to be added to the document.
  void addNode(Node node) {
    nodeKeyList.add(node.key.toString());
    nodeMap[node.key.toString()] = node;
  }

  /// Retrieves a [Node] from the document using the specified [key].
  ///
  /// Returns the [Node] associated with the given [key], or `null` if no such
  /// node exists.
  ///
  /// [key]: The unique identifier for the node to be retrieved.
  Node? getNode(String key) {
    return nodeMap[key];
  }

  /// Retrieves the list of nodes in the document in their sequential order.
  ///
  /// This method returns a list of [Node] objects that represent the
  /// elements of the document arranged in the order they appear.
  ///
  /// Returns:
  ///   A list of [Node] objects in their sequential order.
  List<Node> getNodesInOrder() {
    return nodeKeyList.map((key) => nodeMap[key]!).toList();
  }

  /// Inserts a [Node] at the specified [index] in the document.
  ///
  /// This method allows you to add a new node to the document at a specific
  /// position. The [index] parameter determines the position where the node
  /// will be inserted, and the [node] parameter is the node to be inserted.
  ///
  /// If the [index] is out of bounds, an error may be thrown.
  ///
  /// - Parameters:
  ///   - index: The position in the document where the node should be inserted.
  ///   - node: The node to be inserted into the document.
  void insertNodeAt(int index, Node node) {
    nodeKeyList.insert(index, node.key.toString());
    nodeMap[node.key.toString()] = node;
  }

  /// Removes a node from the document based on the provided key.
  ///
  /// This method searches for a node with the specified [key] and removes it
  /// from the document if found. If the node is not found, no action is taken.
  ///
  /// [key]: The unique identifier of the node to be removed.
  void removeNode(String key) {
    nodeKeyList.remove(key);
    nodeMap.remove(key);
  }

  @override
  String toString() {
    return nodeKeyList.map((key) => nodeMap[key]!).toList().join('\n');
  }

  /// Converts the Document object to a Map representation.
  ///
  /// This method serializes the Document object into a Map<String, dynamic>,
  /// which can be useful for encoding the object into JSON or other formats.
  ///
  /// Returns:
  ///   A Map<String, dynamic> containing the key-value pairs representing
  ///   the properties of the Document object.
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'uuid': uuid,
      'nodeMap': nodeMap.map((key, value) => MapEntry(key, value.toMap())),
      'nodeKeyList': nodeKeyList,
    };
  }

  /// Adds a bidirectional link between two documents.
  ///
  /// This method establishes a two-way connection between the current document
  /// and another specified document. It ensures that both documents are aware
  /// of each other and can reference each other as needed.
  ///
  /// The bidirectional link can be useful for creating relationships between
  /// documents, such as linking related articles, chapters, or sections.
  ///
  /// Example usage:
  /// ```dart
  /// Document doc1 = Document();
  /// Document doc2 = Document();
  /// doc1.addBidirectionalLink(doc2);
  /// ```
  ///
  /// After calling this method, both `doc1` and `doc2` will have references to
  /// each other.
  void addBidirectionalLink(
    String targetDocumentUuid,
    String sourceNodeKey,
    String targetNodeKey,
  ) {
    final sourceNode = getNode(sourceNodeKey);
    final targetNode = getNode(targetNodeKey);

    if (sourceNode != null && targetNode != null) {
      final connectionKey = GlobalKey();
      sourceNode.attribute.connections[connectionKey.toString()] = Connection(
        targetNodeKey: targetNodeKey,
        targetDocumentUuid: targetDocumentUuid,
        sourceDocumentUuid: uuid,
        connectionKey: connectionKey.toString(),
        sourceNodeKey: sourceNodeKey,
      );
    }
  }

  /// Removes a bidirectional link from the document.
  ///
  /// This method is responsible for removing a link that exists in both
  /// directions between two entities within the document. It ensures that
  /// the link is removed from both the source and the target entities.
  ///
  /// The specific implementation details, such as how the entities and links
  /// are represented and stored, are abstracted away in this method.
  ///
  /// Note: Ensure that the entities and links are properly validated before
  /// calling this method to avoid inconsistencies in the document structure.
  void removeBidirectionalLink(
    String sourceNodeKey,
    String connectionKey,
  ) {
    final sourceNode = getNode(sourceNodeKey);

    if (sourceNode != null) {
      sourceNode.attribute.connections.remove(connectionKey);
    }
  }
}
