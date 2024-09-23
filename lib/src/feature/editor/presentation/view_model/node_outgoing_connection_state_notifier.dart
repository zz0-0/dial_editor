import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/node_incoming_connection_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A notifier class that manages the state of outgoing connections for a node
/// in the editor.
///
/// This class is responsible for tracking and updating the state of outgoing
/// connections,
/// ensuring that the connections are properly managed and updated within the
/// editor's context.
/// It provides methods to add, remove, and update connections, as well as
/// notifying listeners
/// about state changes.
///
/// Usage:
/// ```dart
/// final notifier = NodeOutgoingConnectionStateNotifier();
/// notifier.addListener(() {
///   // Handle state changes
/// });
/// notifier.addConnection(connection);
/// ```
///
/// See also:
/// - [NodeIncomingConnectionStateNotifier] for managing incoming connections.
/// - [Connection] for the connection model.
class NodeOutgoingConnectionStateNotifier
    extends StateNotifier<Set<Connection>> {
  /// A notifier for managing the state of outgoing connections for a node.
  ///
  /// This class is responsible for handling the state changes and notifications
  /// related to outgoing connections from a node in the editor.
  ///
  /// Parameters:
  /// - `ref`: A reference to the relevant data or service.
  /// - `key`: A unique identifier for the node.
  NodeOutgoingConnectionStateNotifier(this.ref, this.key)
      : super(<Connection>{}) {
    getOutgoingConnections();
  }

  /// A reference to the provider container, allowing access to other providers.
  ///
  /// This is used to read and manipulate the state of other providers within
  /// the
  /// application.
  ///
  /// Example usage:
  /// ```dart
  /// final someProviderState = ref.read(someProvider);
  /// ```
  final Ref ref;

  /// A global key used to uniquely identify a widget in the widget tree.
  /// This key can be used to access the state of the widget or perform
  /// other operations that require a unique identifier.
  final GlobalKey key;

  // TODO(get): Implement
  /// Retrieves the outgoing connections for the current node.
  ///
  /// This method fetches and processes the outgoing connections
  /// associated with the node in the editor. It does not take any
  /// parameters and does not return any value.
  void getOutgoingConnections() {}

  /// Adds an outgoing connection to the current node.
  ///
  /// This method takes a [Connection] object and adds it to the list of
  /// outgoing connections for the current node. It ensures that the node
  /// can communicate with other nodes through the specified connection.
  ///
  /// [connection] - The connection to be added to the outgoing connections
  /// list.
  void addOutgoingConnections(Connection connection) {
    state.add(connection);
  }
}
