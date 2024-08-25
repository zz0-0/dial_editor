import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

class Document {
  String type = MarkdownElement.document.type;
  GlobalKey key;
  List<GlobalKey> nodeKeyList = [];
  Map<GlobalKey, Node> nodeMap = {};

  Document({required this.key});

  void addNode(Node node) {
    nodeKeyList.add(node.key);
    nodeMap[node.key] = node;
  }

  Node? getNode(GlobalKey key) {
    return nodeMap[key];
  }

  List<Node> getNodesInOrder() {
    return nodeKeyList.map((key) => nodeMap[key]!).toList();
  }

  void insertNodeAt(int index, Node node) {
    nodeKeyList.insert(index, node.key);
    nodeMap[node.key] = node;
  }

  void removeNode(GlobalKey key) {
    nodeKeyList.remove(key);
    nodeMap.remove(key);
  }

  @override
  String toString() {
    return nodeKeyList.map((key) => nodeMap[key]!).toList().join('\n');
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    final document = Document(key: GlobalKey());
    final nodeMap = map['nodeMap'] as Map<String, dynamic>;
    nodeMap.forEach((key, value) {
      final node = Node.fromMap(value as Map<String, dynamic>);
      document.addNode(node);
    });
    return document;
  }

  Map<String, dynamic> toMap() {
    final nodeMap = <GlobalKey, Node>{};
    nodeMap.addEntries(
      nodeMap.entries.map((e) => MapEntry(e.key, e.value.toMap() as Node)),
    );
    return {
      'type': type,
      'key': key,
      'nodeMap': nodeMap,
    };
  }
}
