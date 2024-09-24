import 'package:dial_editor/src/feature/editor/domain/model/document.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Document Tests', () {
    test('addNode should add a node to the nodeKeyList and nodeMap', () {
      final document = Document(uuid: 'test-uuid');
      final node = Node(key: GlobalKey());

      document.addNode(node);

      expect(document.nodeKeyList, contains(node.key.toString()));
      expect(document.nodeMap[node.key.toString()], equals(node));
    });

    test('getNode should return the correct node', () {
      final document = Document(uuid: 'test-uuid');
      final node = Node(key: GlobalKey());
      document.addNode(node);

      final fetchedNode = document.getNode(node.key.toString());

      expect(fetchedNode, equals(node));
    });

    test('getNodesInOrder should return nodes in the order they were added',
        () {
      final document = Document(uuid: 'test-uuid');
      final node1 = Node(key: GlobalKey());
      final node2 = Node(key: GlobalKey());
      document
        ..addNode(node1)
        ..addNode(node2);

      final nodesInOrder = document.getNodesInOrder();

      expect(nodesInOrder, equals([node1, node2]));
    });

    test('insertNodeAt should insert a node at the specified index', () {
      final document = Document(uuid: 'test-uuid');
      final node1 = Node(key: GlobalKey());
      final node2 = Node(key: GlobalKey());
      document
        ..addNode(node1)
        ..insertNodeAt(0, node2);

      expect(
        document.nodeKeyList,
        equals([node2.key.toString(), node1.key.toString()]),
      );
    });

    test('removeNode should remove a node from the nodeKeyList and nodeMap',
        () {
      final document = Document(uuid: 'test-uuid');
      final node = Node(key: GlobalKey());
      document
        ..addNode(node)
        ..removeNode(node.key.toString());

      expect(document.nodeKeyList, isNot(contains(node.key.toString())));
      expect(document.nodeMap[node.key.toString()], isNull);
    });
  });
}
