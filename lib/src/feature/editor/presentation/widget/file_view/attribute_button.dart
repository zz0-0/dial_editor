import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/attribute_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttributeButton extends ConsumerWidget {
  const AttributeButton(this.node, {super.key});
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
