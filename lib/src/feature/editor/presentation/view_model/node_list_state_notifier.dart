import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
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

  void updateList(List<Node> list) {
    state = list;
  }

  Node getNodeByIndex(int index) {
    return state[index];
  }
}
