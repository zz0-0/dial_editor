import 'package:dial_editor/src/feature/file_management/directory/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/domain/model/directory_node_provider.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/widget/directory_node_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Directory extends ConsumerStatefulWidget {
  const Directory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DirectoryState();
}

class _DirectoryState extends ConsumerState<Directory> {
  @override
  Widget build(BuildContext context) {
    final List<DirectoryNode> nodes = ref.watch(directoryNodeListProvider);

    return ListView.builder(
      clipBehavior: Clip.antiAlias,
      shrinkWrap: true,
      itemCount: nodes.length,
      itemBuilder: (context, index) {
        return DirectoryNodeWidget(
          key: nodes[index].key,
          node: nodes[index],
        );
      },
    );
  }
}
