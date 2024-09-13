import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/attribute_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttributeButton extends ConsumerWidget {
  final Node node;

  const AttributeButton(this.node, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Connection> incomingConnectionList =
        ref.watch(nodeIncomingConnectionProvider(node.key));
    final List<Connection> outgoingConnectionList =
        ref.watch(nodeOutgoingConnectionProvider(node.key));

    return IconButton(
      splashRadius: 20,
      icon: const Icon(Icons.arrow_circle_right_outlined),
      onPressed: () => _showAttributeBottomSheet(
        context,
        incomingConnectionList,
        outgoingConnectionList,
      ),
    );
  }

  void _showAttributeBottomSheet(
    BuildContext context,
    List<Connection> incomingConnections,
    List<Connection> outgoingConnections,
  ) {
    showModalBottomSheet(
      showDragHandle: true,
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AttributeBottomSheet(
          incomingConnections: incomingConnections,
          outgoingConnections: outgoingConnections,
        );
      },
    );
  }
}
