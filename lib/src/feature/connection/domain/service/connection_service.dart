import 'package:dial_editor/src/feature/connection/domain/model/connection.dart';
import 'package:dial_editor/src/feature/connection/domain/repository/connection_repository.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

class ConnectionService {
  final ConnectionRepository repository;

  ConnectionService(this.repository);

  Future<void> addConnection(Node source, Node target) async {
    source.outgoingConnections.add(
      Connection(
        sourceDocumentKey: source.documentKey,
        targetDocumentKey: target.documentKey,
        connectionKey: GlobalKey(),
        sourceFileNodeKey: source.key,
        targetFileNodeKey: target.key,
      ),
    );

    target.incomingConnections.add(
      Connection(
        sourceDocumentKey: source.documentKey,
        targetDocumentKey: target.documentKey,
        connectionKey: GlobalKey(),
        sourceFileNodeKey: source.key,
        targetFileNodeKey: target.key,
      ),
    );

    await repository.saveConnection(source, target);
  }

  Future<void> removeConnection(Node source, Node target) async {
    source.outgoingConnections
        .removeWhere((conn) => conn.targetFileNodeKey == target.key);
    target.incomingConnections
        .removeWhere((conn) => conn.sourceFileNodeKey == source.key);

    await repository.deleteConnection(source, target);
  }
}
