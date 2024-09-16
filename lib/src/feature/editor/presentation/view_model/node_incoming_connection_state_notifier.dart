import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NodeIncomingConnectionStateNotifier
    extends StateNotifier<Set<Connection>> {
  final Ref ref;
  final GlobalKey key;
  NodeIncomingConnectionStateNotifier(this.ref, this.key)
      : super(<Connection>{}) {
    getIncomingConnections();
  }

  // TODO: Implement
  void getIncomingConnections() {}

  void addIncomingConnection(Connection connection) {
    state.add(connection);
  }
}
