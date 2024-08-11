import 'package:dial_editor/src/core/provider/side_panel/directory_node_provider.dart';
import 'package:dial_editor/src/core/provider/side_panel/directory_provider.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectoryNodeWidget extends ConsumerWidget {
  final DirectoryNode node;
  final double dx;
  final double dy;

  const DirectoryNodeWidget({
    super.key,
    required this.node,
    required this.dx,
    required this.dy,
  });

  bool isLeaf(DirectoryNode node) {
    return node.children.isEmpty;
  }

  bool isExpanded(WidgetRef ref, Key key) {
    return ref.watch(directoryNodeExpandedProvider(key));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directoryNodeViewModel =
        ref.read(directoryNodeViewModelProvider.notifier);
    final icon = isLeaf(node)
        ? const Icon(Icons.abc)
        : isExpanded(ref, key!)
            ? const Icon(Icons.expand_more)
            : const Icon(Icons.chevron_right);

    return Column(
      children: [
        Row(
          children: [
            if (isLeaf(node))
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: icon,
              )
            else
              IconButton(
                onPressed: () {
                  directoryNodeViewModel.expandNode(ref, key!);
                },
                icon: icon,
              ),
            Flexible(
              child: Material(
                child: InkWell(
                  onTap: () {
                    directoryNodeViewModel.openFile(ref, node);
                  },
                  child: Text(
                    node.content!,
                    style: const TextStyle(fontSize: 8),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isExpanded(ref, key!))
          Padding(
            padding: EdgeInsets.only(
              left: ref.watch(indentationProvider).toDouble(),
            ),
            child: ListView.builder(
              clipBehavior: Clip.antiAlias,
              shrinkWrap: true,
              itemCount: node.children.length,
              itemBuilder: (context, index) {
                return DirectoryNodeWidget(
                  key: node.children[index].key,
                  node: node.children[index],
                  dx: dx,
                  dy: dy,
                );
              },
            ),
          ),
      ],
    );
  }
}
