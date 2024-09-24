import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NodeIncomingConnectionStateNotifier
    extends StateNotifier<Set<Connection>> {
  NodeIncomingConnectionStateNotifier(this.ref, this.key)
      : super(<Connection>{}) {
    getIncomingConnections();
  }
  final Ref ref;
  final GlobalKey key;
  // TODO(get): Implement
  void getIncomingConnections() {}
  void addIncomingConnection(Connection connection) {
    state.add(connection);
  }
}
