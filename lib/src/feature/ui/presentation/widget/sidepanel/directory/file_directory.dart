import 'package:dial_editor/src/feature/file_management/directory/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/provider/directory_provider.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/sidepanel/directory/directory_node_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileDirectory extends ConsumerStatefulWidget {
  const FileDirectory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FileDirectoryState();
}

class _FileDirectoryState extends ConsumerState<FileDirectory> {
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
