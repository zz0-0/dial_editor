import 'dart:collection';

import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_document_children_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A state notifier that manages a list of `Node` objects.
///
/// This class extends `StateNotifier` and is responsible for handling
/// the state of a list of `Node` objects. It provides methods to
/// manipulate the list and notify listeners of any changes.
///
/// The state is represented as a `List<Node>`.
///
/// Example usage:
///
/// ```dart
/// final nodeListNotifier = NodeListStateNotifier();
/// nodeListNotifier.add(Node(...));
/// nodeListNotifier.remove(Node(...));
/// ```
///
/// See also:
/// - [StateNotifier]
/// - [Node]
class NodeListStateNotifier extends StateNotifier<List<Node>> {
  /// A state notifier for managing a list of nodes.
  ///
  /// This class extends the `StateNotifier` with an initial empty list.
  ///
  /// The `NodeListStateNotifier` is responsible for managing the state of a
  /// list of nodes
  /// and notifying listeners of any changes.
  ///
  /// The constructor takes a reference to a provider (`ref`) and initializes
  /// the state
  /// with an empty list.
  ///
  /// ```dart
  /// NodeListStateNotifier(this.ref) : super([]);
  /// ```
  ///
  /// - `ref`: A reference to the provider.
  NodeListStateNotifier(this.ref) : super([]) {
    getList();
  }

  /// A reference to the provider's container, allowing access to other
  /// providers
  /// and their state within the application.
  ///
  /// This is typically used to read or watch other providers, enabling
  /// communication and state management between different parts of the app.
  Ref ref;

  /// A map that associates a [GlobalKey] with a [Block].
  ///
  /// This map is used to keep track of the relationship between
  /// unique global keys and their corresponding block objects
  /// within the editor.
  final Map<GlobalKey, Block> blockMap = {};

  /// A linked list that holds nodes of type `Node`.
  ///
  /// This linked list is used to manage and manipulate a collection of nodes
  /// within the editor's view model. Each node in the list is an instance of
  /// the `Node` class, and the list provides efficient insertion and removal
  /// operations.
  ///
  /// The linked list is initialized as an empty list.
  final LinkedList<Node> nodeLinkedList = LinkedList<Node>();

  /// Retrieves the list of nodes.
  ///
  /// This method fetches the current list of nodes from the data source
  /// and updates the state accordingly.
  void getList() {
    GetDocumentChildrenUseCase getDocumentChildren;
    ref.watch(getDocumentChildrenUseCaseProvider).whenData((value) {
      getDocumentChildren = value;
      getDocumentChildren().then((value) {
        state = value;
      });
    });
  }

  /// Updates the list of nodes.
  ///
  /// This method is responsible for refreshing or modifying the current
  /// list of nodes based on the latest data or user actions.
  void updateList() {
    state = [...state];
  }

  /// Inserts a block node into a map using the provided key.
  ///
  /// This method takes a [GlobalKey] and a [Block] node, and inserts the node
  /// into a map. The key is used to uniquely identify the node within the map.
  ///
  /// - Parameters:
  ///   - key: A [GlobalKey] that uniquely identifies the block node.
  ///   - node: The [Block] node to be inserted into the map.
  void insertBlockNodeIntoMap(GlobalKey key, Block node) {
    blockMap[key] = node;
  }

  /// Inserts an [Inline] node into the flat node list.
  ///
  /// This method takes an [Inline] node and inserts it into the flat node list,
  /// ensuring that the node is properly added to the list structure.
  ///
  /// [node] - The [Inline] node to be inserted into the flat node list.
  void insertNodeIntoFlatNodeList(Inline node) {
    nodeLinkedList.add(node);
  }

  /// Toggles the expansion state of a given inline node.
  ///
  /// This method changes the expansion state of the specified [node].
  /// If the node is currently expanded, it will be collapsed, and vice versa.
  ///
  /// [node] - The inline node whose expansion state is to be toggled.
  void toggleNodeExpansion(Inline node) {
    if (blockMap[node.parentKey] != null) {
      final block = blockMap[node.parentKey]!;
      _toggleChildren(block, node.isExpanded);
    }
  }

  /// Adds a new inline node to the list.
  ///
  /// This method takes an [Inline] object as a parameter and adds it to the
  /// existing list of nodes.
  ///
  /// - Parameter newNode: The new inline node to be added.
  void addNode(Inline newNode) {}

  /// Adds a new node to the current block.
  ///
  /// This method takes a [Node] object as a parameter and adds it to the
  /// existing block of nodes. It ensures that the new node is properly
  /// integrated into the block's structure.
  ///
  /// [newNode] - The node to be added to the block.
  void addNodeToBlock(Node newNode) {
    if (_blockExists(newNode.parentKey)) {
      final block = blockMap[newNode.parentKey]!;
      block.children.add(newNode);
      _updateBlock(newNode.parentKey!, block);
    }
  }

  /// Inserts a new node into a block, replacing an old node.
  ///
  /// This method takes an existing node (`oldNode`) and replaces it with a
  /// new node (`newNode`) within a block. It ensures that the block is updated
  /// with the new node while maintaining the structure and integrity of the
  /// block.
  ///
  /// - Parameters:
  ///   - oldNode: The node that is to be replaced.
  ///   - newNode: The node that will replace the old node.
  void insertNodeToBlock(Node oldNode, Node newNode) {
    if (_blockExists(newNode.parentKey)) {
      final block = blockMap[newNode.parentKey]!;
      final index = block.children.indexOf(oldNode);
      block.children.insert(index + 1, newNode);
      _updateBlock(newNode.parentKey!, block);
      oldNode.insertAfter(newNode);
    }
  }

  /// Inserts a new node into the root, replacing the old node.
  ///
  /// This method takes an existing node (`oldNode`) and a new node (`newNode`),
  /// and replaces the old node with the new node in the root structure.
  ///
  /// - Parameters:
  ///   - oldNode: The node to be replaced.
  ///   - newNode: The node to be inserted in place of the old node.
  void insertNodeToRoot(Node oldNode, Node newNode) {
    final index = state.indexOf(oldNode);
    state.insert(index + 1, newNode);
    updateList();
    oldNode.insertAfter(newNode);
  }

  /// Replaces an existing inline node with a new inline node within a block.
  ///
  /// This method searches for the specified [oldNode] within the block and
  /// replaces it with the provided [newNode].
  ///
  /// - Parameters:
  ///   - oldNode: The inline node to be replaced.
  ///   - newNode: The inline node to replace the old node with.
  void replaceNodeInBlock(Inline oldNode, Inline newNode) {
    if (!_blockExists(oldNode.parentKey)) return;

    final block = blockMap[oldNode.parentKey]!;
    final index = block.children.indexOf(oldNode);

    if (oldNode is Heading && newNode is! Heading) {
      _handleHeadingToTextConversion(block, index, oldNode, newNode);
      // _updateDocumentToDatabase();
    } else if (newNode is Heading) {
      _handleHeadingReplacement(block, index, oldNode, newNode);
      // _updateDocumentToDatabase();
    } else if (_isSpecialBlockNode(newNode)) {
      _handleSpecialBlockReplacement(block, index, oldNode, newNode);
      // _updateDocumentToDatabase();
    } else if (_isSpecialBlockNode(oldNode) &&
        newNode.runtimeType != oldNode.runtimeType) {
      _handleSpecialBlockNodeToTextReplacement(block, index, oldNode, newNode);
      // _updateDocumentToDatabase();
    } else {
      _handleSimpleReplacement(block, index, oldNode, newNode);
      // _updateChunkToDatabase();
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

        for (var i = 0; i < block.children.length - 1; i++) {
          if (i != index) {
            final child = block.children[i]..parentKey = block.parentKey;
            parentBlock.children.insert(index + 1 + i, child);
          }
        }
        _updateBlock(parentBlock.key, parentBlock);
        blockMap.remove(block.key);
      } else {
        if (index > 0) {
          block.children[index - 1].insertAfter(newNode);
          nodeLinkedList.remove(oldNode);
          state[index] = newNode;
          for (var i = 0; i < block.children.length - 1; i++) {
            if (i != index) {
              final child = block.children[i];

              state.insert(index + 1 + i, child);
            }
          }
        } else {
          final oldBlockIndex = state.indexOf(block);
          final newContent = <Node>[newNode];
          for (var i = 0; i < block.children.length; i++) {
            if (i != index) {
              newContent.add(block.children[i]);
            }
          }
          state
            ..removeAt(oldBlockIndex)
            ..insertAll(oldBlockIndex, newContent);
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
    final newBlock = _createHeadingBlock(newNode);
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
    final newBlock = HeadingBlock(level: newNode.level, key: GlobalKey());
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
    final newBlock = _createSpecialBlock(newNode);
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

  /// Retrieves the previous node in the list relative to the given node.
  ///
  /// This method takes an [Inline] node as a parameter and returns the
  /// previous [Inline] node in the list, if it exists. If the given node
  /// is the first node or if the previous node cannot be determined,
  /// the method returns `null`.
  ///
  /// - Parameter node: The current [Inline] node for which the previous
  ///   node is to be found.
  /// - Returns: The previous [Inline] node if it exists, otherwise `null`.
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

  /// Retrieves the next node in the sequence after the given [node].
  ///
  /// This method takes an [Inline] node as input and returns the next
  /// [Inline] node in the sequence. If there is no next node, it returns null.
  ///
  /// - Parameter node: The current [Inline] node.
  /// - Returns: The next [Inline] node in the sequence, or null if there is no
  /// next node.
  Inline? getNextNode(Inline node) {
    Inline? nextNode;
    if (nodeLinkedList.isNotEmpty) {
      if (node.next != null) {
        nextNode = node.next! as Inline;
      }
    }
    return nextNode;
  }

  /// Removes the specified [node] from the block.
  ///
  /// This method takes an [Inline] node and removes it from the current block.
  ///
  /// [node]: The inline node to be removed from the block.
  void removeNodeFromBlock(Inline node) {
    if (_blockExists(node.parentKey)) {
      final block = blockMap[node.parentKey]!;
      block.children.remove(node);
      _updateBlock(node.parentKey!, block);
      nodeLinkedList.remove(node);
    }
  }

  /// Removes the specified [node] from the root node list.
  ///
  /// This method takes an [Inline] node as a parameter and removes it from
  /// the root node list if it exists.
  ///
  /// [node]: The [Inline] node to be removed from the root node list.
  void removeNodeFromRoot(Inline node) {
    state.remove(node);
    updateList();
    nodeLinkedList.remove(node);
  }

  /// Clears the current selection of nodes.
  ///
  /// This method resets any selected nodes to their default state,
  /// effectively clearing any user selections made in the editor.
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
}
