import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/attribute_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents an attribute button in the file view.
///
/// This widget is used within the editor feature to provide a button
/// that can be associated with a specific attribute. It utilizes the
/// `ConsumerWidget` from the `flutter_riverpod` package to listen to
/// and react to changes in the state.
///
/// The `AttributeButton` can be customized and extended to handle
/// various attributes as needed within the editor.
///
/// Usage:
/// ```dart
/// AttributeButton(
///   // Add necessary parameters here
/// )
/// ```
///
/// Note: Ensure that the necessary providers are set up in the widget
/// tree to use this widget effectively.
class AttributeButton extends ConsumerWidget {
  /// A widget that represents a button for a specific attribute in the editor.
  ///
  /// The [AttributeButton] is associated with a particular node and provides
  /// functionality related to that node.
  ///
  /// The [node] parameter is required and specifies the node associated with
  /// this button.
  ///
  /// The [key] parameter is optional and can be used to uniquely identify
  /// this widget in the widget tree.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// AttributeButton(node);
  /// ```
  const AttributeButton(this.node, {super.key});

  /// A node representing a specific element or component in the editor.
  /// This is used to manage and manipulate the attributes of the element.
  final Node node;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomingConnectionList =
        ref.watch(nodeIncomingConnectionProvider(node.key));
    final outgoingConnectionList =
        ref.watch(nodeOutgoingConnectionProvider(node.key));

    return IconButton(
      splashRadius: 20,
      icon: const Icon(Icons.arrow_circle_right_outlined),
      onPressed: () => _showAttributeBottomSheet(
        context,
        node.key,
        incomingConnectionList,
        outgoingConnectionList,
      ),
    );
  }

  void _showAttributeBottomSheet(
    BuildContext context,
    GlobalKey key,
    Set<Connection> incomingConnections,
    Set<Connection> outgoingConnections,
  ) {
    showModalBottomSheet<void>(
      showDragHandle: true,
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AttributeBottomSheet(
          nodeKey: key,
          incomingConnections: incomingConnections,
          outgoingConnections: outgoingConnections,
        );
      },
    );
  }
}
