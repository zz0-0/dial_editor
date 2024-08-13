import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_document_children_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NodeListStateNotifier extends StateNotifier<List<Node>> {
  Ref ref;
  final Map<GlobalKey, Block> blockMap = {};

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
    }
  }

  Inline getPreviousNode(Inline node) {
    late Inline previousNode;
    if (_blockExists(node.parentKey)) {
      final block = blockMap[node.parentKey]!;
      final index = block.children.indexOf(node);
      if (index > 0) {
        previousNode = block.children[index - 1] as Inline;
      }
    }
    return previousNode;
  }

  void removeNodeFromBlock(Inline node) {
    if (_blockExists(node.parentKey)) {
      final block = blockMap[node.parentKey]!;
      block.children.remove(node);
      _updateBlock(node.parentKey!, block);
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
