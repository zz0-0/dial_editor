import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AttributeType { key, incoming, outgoing }

class AttributeButton extends ConsumerStatefulWidget {
  final AttributeType type;
  final Node node;
  const AttributeButton(this.type, this.node, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AttributeButtonState();
}

class _AttributeButtonState extends ConsumerState<AttributeButton> {
  @override
  Widget build(BuildContext context) {
    late final IconData icon;
    final List<Connection> items =
        ref.watch(nodeIncomingConnectionProvider(widget.node.key));

    if (widget.type == AttributeType.key) {
      icon = Icons.outlined_flag;
      return Chip(
        avatar: Icon(icon),
        label: Text(
          widget.node.attribute.key.toString().substring(
                widget.node.attribute.key.toString().length - 7,
                widget.node.attribute.key.toString().length - 1,
              ),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    } else if (widget.type == AttributeType.incoming) {
      icon = Icons.arrow_circle_left_outlined;
      return MenuAnchor(
        menuChildren: [
          ...items.map(
            (item) => MenuItemButton(
              child: Text(item.targetNodeKey),
              onPressed: () {},
            ),
          ),
          MenuItemButton(
            child: const Text('Add item'),
            onPressed: () {
              Scaffold.of(context).showBottomSheet(
                (context) => Container(
                  height: 200,
                  color: Colors.red,
                ),
              );
            },
          ),
        ],
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return ActionChip.elevated(
            avatar: Icon(icon),
            label: Text(items.length.toString()),
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
          );
        },
      );
    } else {
      icon = Icons.arrow_circle_right_outlined;
      return Container();
    }
  }
}
