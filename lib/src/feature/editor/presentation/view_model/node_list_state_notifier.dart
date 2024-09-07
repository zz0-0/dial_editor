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
    newList.then((value) {
      state = value;
    });
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
      final Block block = blockMap[node.parentKey]!;
      _toggleChildren(block, node.isExpanded);
    }
  }

  void addNode(Inline newNode) {}

  void addNodeToBlock(Node newNode) {
    if (_blockExists(newNode.parentKey)) {
      final block = blockMap[newNode.parentKey]!;
      block.children.add(newNode);
      _updateBlock(newNode.parentKey!, block);
    }
  }

  void insertNodeToBlock(Node oldNode, Node newNode) {
    if (_blockExists(newNode.parentKey)) {
      final block = blockMap[newNode.parentKey]!;
      final index = block.children.indexOf(oldNode);
      block.children.insert(index + 1, newNode);
      _updateBlock(newNode.parentKey!, block);
      oldNode.insertAfter(newNode);
    }
  }

  void replaceNodeInBlock(Inline oldNode, Inline newNode) {
    if (!_blockExists(oldNode.parentKey)) return;

    final block = blockMap[oldNode.parentKey]!;
    final index = block.children.indexOf(oldNode);

    if (oldNode is Heading && newNode is! Heading) {
      _handleHeadingToTextConversion(block, index, oldNode, newNode);
      _updateDocumentToDatabase();
    } else if (newNode is Heading) {
      _handleHeadingReplacement(block, index, oldNode, newNode);
      _updateDocumentToDatabase();
    } else if (_isSpecialBlockNode(newNode)) {
      _handleSpecialBlockReplacement(block, index, oldNode, newNode);
      _updateDocumentToDatabase();
    } else if (_isSpecialBlockNode(oldNode) &&
        newNode.runtimeType != oldNode.runtimeType) {
      _handleSpecialBlockNodeToTextReplacement(block, index, oldNode, newNode);
      _updateDocumentToDatabase();
    } else {
      _handleSimpleReplacement(block, index, oldNode, newNode);
      _updateChunkToDatabase();
    }
  }

  void _handleHeadingToTextConversion(
    Block block,
    int index,
    Inline oldNode,
    Inline newNode,
  ) {
    if (block is HeadingBlock) {
      if (block.parentKey != null) {
        final parentBlock = blockMap[block.parentKey];
        if (parentBlock == null) return;
        oldNode.insertAfter(newNode);
        nodeLinkedList.remove(oldNode);
        parentBlock.children[index] = newNode;
        newNode.parentKey = parentBlock.key;

        for (int i = 0; i < block.children.length - 1; i++) {
          if (i != index) {
            final child = block.children[i];

            child.parentKey = block.parentKey;
            parentBlock.children.insert(index + 1 + i, child);
          }
        }
        _updateBlock(parentBlock.key, parentBlock);
        blockMap.remove(block.key);
      } else {
        if (index > 0) {
          final previousNode = block.children[index - 1];
          previousNode.insertAfter(newNode);
          nodeLinkedList.remove(oldNode);
          state[index] = newNode;
          for (int i = 0; i < block.children.length - 1; i++) {
            if (i != index) {
              final child = block.children[i];

              state.insert(index + 1 + i, child);
            }
          }
        } else {
          final int oldBlockIndex = state.indexOf(block);
          final List<Node> newContent = [];
          newContent.add(newNode);
          for (int i = 0; i < block.children.length; i++) {
            if (i != index) {
              newContent.add(block.children[i]);
            }
          }
          state.removeAt(oldBlockIndex);
          state.insertAll(oldBlockIndex, newContent);
          oldNode.insertAfter(newNode);
          nodeLinkedList.remove(oldNode);
        }

        blockMap.remove(block.key);
      }
    }
  }

  void _handleHeadingReplacement(
    Block block,
    int index,
    Inline oldNode,
    Heading newNode,
  ) {
    final HeadingBlock newBlock = _createHeadingBlock(newNode);
    _moveChildrenToNewBlock(block, index, newBlock);

    if (block is HeadingBlock) {
      if (newBlock.level >= block.level) {
        _moveBlockToHigherLevel(block, index, newBlock);
      } else {
        _replaceExistingBlock(block, index, newBlock);
      }
      oldNode.insertAfter(newNode);
      nodeLinkedList.remove(oldNode);
    }
  }

  HeadingBlock _createHeadingBlock(Heading newNode) {
    newNode.isBlockStart = true;
    final HeadingBlock newBlock =
        HeadingBlock(level: newNode.level, key: GlobalKey());
    newBlock.children.add(newNode);
    newNode.parentKey = newBlock.key;
    return newBlock;
  }

  void _moveChildrenToNewBlock(Block block, int index, Block newBlock) {
    if (index < block.children.length - 1) {
      for (final child in block.children.sublist(index + 1)) {
        if (child is Inline) child.parentKey = newBlock.key;
        newBlock.children.add(child);
      }
      block.children.removeRange(index + 1, block.children.length);
    }
  }

  void _moveBlockToHigherLevel(
    HeadingBlock block,
    int index,
    HeadingBlock newBlock,
  ) {
    block.children.removeAt(index);
    newBlock.parentKey = block.parentKey;

    if (block.parentKey != null) {
      final parentBlock = blockMap[block.parentKey]!;
      final blockIndex = parentBlock.children.indexOf(block);
      parentBlock.children.insert(blockIndex + 1, newBlock);
      _moveChildrenToNewBlock(parentBlock, blockIndex + 1, newBlock);
      _updateBlock(parentBlock.key, parentBlock);
    } else {
      state.insert(state.indexOf(block) + 1, newBlock);
    }

    _updateBlock(newBlock.key, newBlock);
  }

  void _replaceExistingBlock(Block block, int index, Block newBlock) {
    block.children[index] = newBlock;
    newBlock.parentKey = block.key;
    _updateBlock(block.key, block);
    _updateBlock(newBlock.key, newBlock);
  }

  bool _isSpecialBlockNode(Inline node) {
    return node is CodeBlockMarker ||
        node is OrderedListNode ||
        node is TaskListNode ||
        node is UnorderedListNode ||
        node is Math ||
        node is Quote;
  }

  void _handleSpecialBlockReplacement(
    Block block,
    int index,
    Inline oldNode,
    Inline newNode,
  ) {
    newNode.isBlockStart = true;
    final Block newBlock = _createSpecialBlock(newNode);
    newBlock.children.add(newNode);
    newNode.parentKey = newBlock.key;
    block.children[index] = newBlock;
    newBlock.parentKey = block.key;
    _updateBlock(block.key, block);
    _updateBlock(newBlock.key, newBlock);
    oldNode.insertAfter(newNode);
    nodeLinkedList.remove(oldNode);
  }

  Block _createSpecialBlock(Inline newNode) {
    if (newNode is CodeBlockMarker) {
      return CodeBlock(key: GlobalKey());
    }
    if (newNode is OrderedListNode) {
      return OrderedListBlock(key: GlobalKey());
    }
    if (newNode is TaskListNode) {
      return TaskListBlock(key: GlobalKey());
    }
    if (newNode is UnorderedListNode) {
      return UnorderedListBlock(key: GlobalKey());
    }
    if (newNode is Math) return MathBlock(key: GlobalKey());
    return QuoteBlock(key: GlobalKey());
  }

  void _handleSpecialBlockNodeToTextReplacement(
    Block block,
    int index,
    Inline oldNode,
    Inline newNode,
  ) {
    if (block.parentKey != null) {
      final parentBlock = blockMap[block.parentKey];
      if (parentBlock == null) return;
      newNode.parentKey = parentBlock.key;
      parentBlock.children
          .insert(parentBlock.children.indexOf(block) + 1, newNode);
      block.children.remove(oldNode);
      _updateBlock(block.key, block);
      _updateBlock(parentBlock.key, parentBlock);
      oldNode.insertAfter(newNode);
      nodeLinkedList.remove(oldNode);
    }
  }

  void _handleSimpleReplacement(
    Block block,
    int index,
    Inline oldNode,
    Inline newNode,
  ) {
    block.children[index] = newNode;
    oldNode.insertAfter(newNode);
    nodeLinkedList.remove(oldNode);
    _updateBlock(oldNode.parentKey!, block);
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

  void clearSelection() {
    for (final node in nodeLinkedList) {
      ref.read(nodeStateProvider(node.key).notifier).clearSelection();
    }
  }

  bool _blockExists(GlobalKey? key) {
    return key != null && blockMap[key] != null;
  }

  void _updateBlock(GlobalKey key, Block block) {
    blockMap[key] = block;
    updateList();
  }

  void _toggleChildren(Block block, bool isExpanded, [bool nested = false]) {
    for (final child in block.children) {
      if (child is Inline) {
        if (!child.isBlockStart) {
          ref.read(nodeStateProvider(child.key).notifier).toggleNodeExpansion();
        }
        if (nested) {
          ref.read(nodeStateProvider(child.key).notifier).toggleNodeExpansion();
        }
      } else if (child is Block) {
        _toggleChildren(child, isExpanded, true);
      }
    }
  }

  void _updateDocumentToDatabase() {
    // ref.read(documentRepositoryProvider).saveDocumentToDatabase();
  }

  void _updateChunkToDatabase() {}
}
