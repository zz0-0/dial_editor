import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NodeListStateNotifier extends StateNotifier<List<Node>> {
  Ref ref;

  NodeListStateNotifier(this.ref) : super([]);

  List<Node> getList() {
    return state;
  }

  int getListLength() {
    return state.length;
  }

  // ignore: use_setters_to_change_properties
  void updateList(List<Node> list) {
    state = list;
  }

  Node getNodeByIndex(int index) {
    return state[index];
  }

  Block? findBlockByKey(GlobalKey key) {
    final List<Node> list = [...state];
    return findBlock(list, key);
  }

  Block? findBlock(List<Node> list, GlobalKey key) {
    for (final node in list) {
      if (node is Block && node.key == key) {
        return node;
      } else if (node is Block && node.children.isNotEmpty) {
        final Block? result = findBlock(node.children, key);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }

  void updateBlock(Block block) {
    final List<Node> list = [...state];
    final index = list.indexWhere((element) => element.key == block.key);
    list[index] = block;
    state = list;
  }

  void findFollowingBlockAndInsert(GlobalKey key, Block block) {
    final List<Node> list = [...state];
    int index = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].key == key) {
        index = i;
      }
    }
    list.insert(index, block);
    state = list;
  }
}
