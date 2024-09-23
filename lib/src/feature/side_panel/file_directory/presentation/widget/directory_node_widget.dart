import 'package:dial_editor/src/core/provider/side_panel/directory_node_provider.dart';
import 'package:dial_editor/src/core/provider/side_panel/directory_provider.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents a directory node in the file directory side panel.
///
/// This widget is a consumer widget, which means it listens to changes in the
/// provider and rebuilds accordingly.
///
/// Usage:
/// ```dart
/// DirectoryNodeWidget();
/// ```
///
/// This widget is typically used within the file directory side panel to
/// display and interact with directory nodes.
///
/// See also:
///  * [ConsumerWidget], which this widget extends.
class DirectoryNodeWidget extends ConsumerWidget {
  /// A widget that represents a directory node in the file directory side
  /// panel.
  const DirectoryNodeWidget({
    required this.node,
    required this.dx,
    required this.dy,
    super.key,
  });

  /// A final variable that holds an instance of the `DirectoryNode` class.
  final DirectoryNode node;

  /// A final variable representing the horizontal offset of the node.
  final double dx;

  /// A final variable representing the vertical offset of the node.
  final double dy;

  /// Checks if the given [DirectoryNode] is a leaf node.
  ///
  /// A leaf node is a node that does not have any children.
  ///
  /// Returns `true` if the node is a leaf, otherwise `false`.
  bool isLeaf(DirectoryNode node) {
    return node.children.isEmpty;
  }

  /// Checks if the directory node represented by the given [key] is expanded.
  ///
  /// This method uses the provided [ref] to access the state and determine
  /// whether the directory node is currently expanded.
  ///
  /// - Parameters:
  ///   - ref: A reference to the widget's state.
  ///   - key: The key representing the directory node.
  ///
  /// - Returns: A boolean value indicating whether the directory node is
  /// expanded.
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
                padding: const EdgeInsets.all(8),
                child: icon,
              )
            else
              IconButton(
                splashRadius: 20,
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
