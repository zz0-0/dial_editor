import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AttributeType { key, incoming, outgoing }

class AttributeButton extends ConsumerStatefulWidget {
  final AttributeType type;
  final String content;
  const AttributeButton(this.type, this.content, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AttributeButtonState();
}

class _AttributeButtonState extends ConsumerState<AttributeButton> {
  @override
  Widget build(BuildContext context) {
    late final IconData icon;
    final List<String> items = ['a', 'b', 'c'];

    if (widget.type == AttributeType.key) {
      icon = Icons.outlined_flag;
      return Chip(
        avatar: Icon(icon),
        label: Text(widget.content),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    } else if (widget.type == AttributeType.incoming) {
      icon = Icons.arrow_circle_left_outlined;
      return MenuAnchor(
        menuChildren: [
          ...items.map(
            (item) => MenuItemButton(
              child: Text(item),
              onPressed: () {},
            ),
          ),
          MenuItemButton(
            child: const Text('Add item'),
            onPressed: () {},
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
