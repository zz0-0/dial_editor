import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

class Document {
  String uuid;
  String type = MarkdownElement.document.type;
  List<String> nodeKeyList = [];
  Map<String, Node> nodeMap = {};

  Document({required this.uuid});

  void addNode(Node node) {
    nodeKeyList.add(node.key.toString());
    nodeMap[node.key.toString()] = node;
  }

  Node? getNode(String key) {
    return nodeMap[key];
  }

  List<Node> getNodesInOrder() {
    return nodeKeyList.map((key) => nodeMap[key]!).toList();
  }

  void insertNodeAt(int index, Node node) {
    nodeKeyList.insert(index, node.key.toString());
    nodeMap[node.key.toString()] = node;
  }

  void removeNode(String key) {
    nodeKeyList.remove(key);
    nodeMap.remove(key);
  }

  @override
  String toString() {
    return nodeKeyList.map((key) => nodeMap[key]!).toList().join('\n');
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    final document = Document(uuid: map['uuid'] as String);
    final Map<String, dynamic> nodeMapData =
        map['nodeMap'] as Map<String, dynamic>;
    nodeMapData.forEach((key, value) {
      final node = Node.fromMap(value as Map<String, dynamic>);
      document.addNode(node);
    });

    return document;
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'uuid': uuid,
      'nodeMap': nodeMap.map((key, value) => MapEntry(key, value.toMap())),
      'nodeKeyList': nodeKeyList,
    };
  }

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
