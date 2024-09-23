import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A notifier class that manages the state of incoming connections for a node.
///
/// This class is responsible for tracking and updating the state of incoming
/// connections to a node within the editor. It notifies listeners when the
/// state changes, allowing the UI or other components to react accordingly.
///
/// Typical usage:
///
/// ```dart
/// final notifier = NodeIncomingConnectionStateNotifier();
/// notifier.addListener(() {
///   // Handle state changes
/// });
/// ```
///
/// Listeners can be added to this notifier to respond to changes in the
/// incoming connection state.
class NodeIncomingConnectionStateNotifier
    extends StateNotifier<Set<Connection>> {
  /// Constructs a [NodeIncomingConnectionStateNotifier] instance.
  NodeIncomingConnectionStateNotifier(this.ref, this.key)
      : super(<Connection>{}) {
    getIncomingConnections();
  }

  /// A reference to the provider container, allowing access to other providers.
  ///
  /// This is used to read and manipulate the state of various providers within
  /// the application.
  ///
  /// Example usage:
  /// ```dart
  /// final someProviderValue = ref.read(someProvider);
  /// ```
  final Ref ref;

  /// A global key used to uniquely identify a widget in the widget tree.
  /// This key can be used to access the widget's state and perform operations
  /// such as scrolling or focusing on the widget.
  final GlobalKey key;

  // TODO(get): Implement
  /// Retrieves the incoming connections for the node.
  ///
  /// This method is responsible for fetching and handling the incoming
  /// connections associated with the node. It does not take any parameters
  /// and does not return any value.
  void getIncomingConnections() {}

  /// Adds an incoming connection to the node.
  ///
  /// This method takes a [Connection] object and adds it to the list of
  /// incoming connections for the node. It ensures that the node can
  /// properly handle incoming data or signals from the specified connection.
  ///
  /// [connection]: The connection to be added to the node's incoming
  /// connections.
  void addIncomingConnection(Connection connection) {
    state.add(connection);
  }
}
