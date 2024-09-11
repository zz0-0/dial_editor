import 'package:animated_tree_view/animated_tree_view.dart' as atv;
import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AttributeType { key, incoming, outgoing }

enum NodeType { all, file, block, inline }

class AttributeButton extends ConsumerStatefulWidget {
  final AttributeType type;
  final Node node;

  const AttributeButton(
    this.type,
    this.node, {
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AttributeButtonState();
}

class _AttributeButtonState extends ConsumerState<AttributeButton> {
  @override
  Widget build(BuildContext context) {
    late final IconData icon;
    final List<Connection> incomingConnectionList =
        ref.watch(nodeIncomingConnectionProvider(widget.node.key));
    final atv.TreeNode tree = ref.watch(treeNodeProvider);
    final Set<NodeType> filters = {};

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
          ...incomingConnectionList.map(
            (connection) => MenuItemButton(
              child: Text(connection.targetNodeKey),
              onPressed: () {},
            ),
          ),
          MenuItemButton(
            child: const Text('Add item'),
            onPressed: () {
              Scaffold.of(context).showBottomSheet(
                (context) => Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(labelText: 'Search'),
                          ),
                        ),
                        ElevatedButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 5,
                      children: NodeType.values
                          .map(
                            (type) => FilterChip(
                              label: Text(type.toString().split('.').last),
                              selected: filters.contains(type),
                              onSelected: (selected) {
                                if (selected) {
                                  filters.add(type);
                                } else {
                                  filters.remove(type);
                                }
                              },
                            ),
                          )
                          .toList(),
                    ),
                    Expanded(
                      child: tree.children.isNotEmpty
                          ? atv.TreeView.simple(
                              showRootNode: false,
                              tree: tree,
                              builder: (context, item) {
                                return ListTile(
                                  leading: Checkbox(
                                    value:
                                        ref.watch(checkboxProvider(item.key)),
                                    onChanged: (value) {
                                      setState(() {
                                        ref
                                            .read(
                                              checkboxProvider(item.key)
                                                  .notifier,
                                            )
                                            .update((state) => value);
                                      });
                                    },
                                  ),
                                  title: Text(
                                    '${item.data}',
                                  ),
                                  onTap: () {},
                                );
                              },
                            )
                          : const Center(
                              child: Text('No items found'),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return ActionChip.elevated(
            avatar: Icon(icon),
            label: Text(incomingConnectionList.length.toString()),
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
