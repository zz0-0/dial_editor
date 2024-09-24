import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NodeOutgoingConnectionStateNotifier
    extends StateNotifier<Set<Connection>> {
  NodeOutgoingConnectionStateNotifier(this.ref, this.key)
      : super(<Connection>{}) {
    getOutgoingConnections();
  }
  final Ref ref;
  final GlobalKey key;
  // TODO(get): Implement
  void getOutgoingConnections() {}
  void addOutgoingConnections(Connection connection) {
    state.add(connection);
  }
}
