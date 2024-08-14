import 'dart:collection';

import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_document_children_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NodeListStateNotifier extends StateNotifier<List<Node>> {
  Ref ref;
  final Map<GlobalKey, Block> blockMap = {};
  final LinkedList<Node> nodeLinkedList = LinkedList<Node>();

  NodeListStateNotifier(this.ref) : super([]) {
    getList();
  }

  void getList() {
    final GetDocumentChildrenUseCase getDocumentChildren =
        ref.watch(getDocumentChildrenUseCaseProvider);
    final newList = getDocumentChildren.getChildren();
    if (state != newList) {
      state = newList;
    } else {
      // print('State not updated, list is the same');
    }
  }

  void updateList() {
    state = [...state];
  }

  void insertBlockNodeIntoMap(GlobalKey key, Block node) {
    blockMap[key] = node;
  }

  void insertNodeIntoFlatNodeList(Inline node) {
    nodeLinkedList.add(node);
  }

  void toggleNodeExpansion(Inline node) {
    if (blockMap[node.parentKey] != null) {
      for (final n in blockMap[node.parentKey]!.children) {
        if (n is Inline) {
          if (!n.isBlockStart) {
            ref.read(nodeStateProvider(n.key).notifier).toggleNodeExpansion();
          }
        }
      }
    }
  }

  void addNode(Inline newNode) {}

  void addNodeToBlock(Inline newNode) {
    if (_blockExists(newNode.parentKey)) {
      final block = blockMap[newNode.parentKey]!;
      block.children.add(newNode);
      _updateBlock(newNode.parentKey!, block);
    }
  }

  void insertNodeToBlock(Inline oldNode, Inline newNode) {
    if (_blockExists(newNode.parentKey)) {
      final block = blockMap[newNode.parentKey]!;
      final index = block.children.indexOf(oldNode);
      block.children.insert(index + 1, newNode);
      _updateBlock(newNode.parentKey!, block);
      oldNode.insertAfter(newNode);
    }
  }

  void replaceNodeInBlock(Inline oldNode, Inline newNode) {
    if (_blockExists(oldNode.parentKey)) {
      final block = blockMap[oldNode.parentKey]!;
      final index = block.children.indexOf(oldNode);
      block.children[index] = newNode;
      _updateBlock(newNode.parentKey!, block);
      oldNode.insertAfter(newNode);
      nodeLinkedList.remove(oldNode);
    }
  }

  Inline? getPreviousNode(Inline node) {
    Inline? previousNode;
    if (nodeLinkedList.isNotEmpty) {
      if (node.previous != null) {
        if (node.previous is Inline) {
          previousNode = node.previous! as Inline;
        } else if (node.previous is Block) {
          previousNode = (node.previous! as Block).children.last as Inline;
        }
      }
    }
    return previousNode;
  }

  Inline? getNextNode(Inline node) {
    Inline? nextNode;
    if (nodeLinkedList.isNotEmpty) {
      if (node.next != null) {
        nextNode = node.next! as Inline;
      }
    }
    return nextNode;
  }

  void removeNodeFromBlock(Inline node) {
    if (_blockExists(node.parentKey)) {
      final block = blockMap[node.parentKey]!;
      block.children.remove(node);
      _updateBlock(node.parentKey!, block);
      nodeLinkedList.remove(node);
    }
  }

  bool _blockExists(GlobalKey? key) {
    return key != null && blockMap[key] != null;
  }

  void _updateBlock(GlobalKey key, Block block) {
    blockMap[key] = block;
    updateList();
  }
}
