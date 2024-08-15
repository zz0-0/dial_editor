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
      _handleHeadingToTextConversion(block, index, newNode);
    } else if (newNode is Heading) {
      _handleHeadingReplacement(block, index, newNode);
    } else if (_isSpecialBlockNode(newNode)) {
      _handleSpecialBlockReplacement(block, index, newNode, oldNode);
    } else {
      _handleSimpleReplacement(block, index, newNode, oldNode);
    }
  }

  void _handleHeadingToTextConversion(Block block, int index, Inline newNode) {}

  void _handleHeadingReplacement(Block block, int index, Heading newNode) {
    final HeadingBlock newBlock = _createHeadingBlock(newNode);
    _moveChildrenToNewBlock(block, index, newBlock);

    if (block is HeadingBlock) {
      if (newBlock.level >= block.level) {
        _moveBlockToHigherLevel(block, index, newBlock);
      } else {
        _replaceExistingBlock(block, index, newBlock);
      }
    }
  }

  HeadingBlock _createHeadingBlock(Heading newNode) {
    newNode.isBlockStart = true;
    final HeadingBlock newBlock = HeadingBlock(level: newNode.level);
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
      blockMap[block.parentKey!] = parentBlock;
    } else {
      state.insert(state.indexOf(block) + 1, newBlock);
    }

    blockMap[newBlock.key] = newBlock;
  }

  void _replaceExistingBlock(Block block, int index, Block newBlock) {
    block.children[index] = newBlock;
    newBlock.parentKey = block.key;
    blockMap[newBlock.key] = newBlock;
    blockMap[block.key] = block;
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
    Inline newNode,
    Inline oldNode,
  ) {
    newNode.isBlockStart = true;
    final Block newBlock = _createSpecialBlock(newNode);
    _moveChildrenToNewBlock(block, index, newBlock);
    block.children[index] = newBlock;
    newBlock.parentKey = block.key;
    blockMap[newBlock.key] = newBlock;
    blockMap[block.key] = block;
    oldNode.insertAfter(newNode);
    nodeLinkedList.remove(oldNode);
  }

  Block _createSpecialBlock(Inline newNode) {
    if (newNode is CodeBlockMarker) return CodeBlock();
    if (newNode is OrderedListNode) return OrderedListBlock();
    if (newNode is TaskListNode) return TaskListBlock();
    if (newNode is UnorderedListNode) return UnorderedListBlock();
    if (newNode is Math) return MathBlock();
    return QuoteBlock();
  }

  void _handleSimpleReplacement(
    Block block,
    int index,
    Inline newNode,
    Inline oldNode,
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
}
