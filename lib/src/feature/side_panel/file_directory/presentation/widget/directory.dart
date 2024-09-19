import 'package:dial_editor/src/core/provider/side_panel/directory_provider.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/presentation/widget/directory_node_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Directory extends ConsumerWidget {
  const Directory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nodes = ref.watch(directoryViewModelProvider);
    return SizedBox(
      width: 200,
      child: ListView.builder(
        clipBehavior: Clip.antiAlias,
        shrinkWrap: true,
        itemCount: nodes.length,
        itemBuilder: (context, index) {
          return DirectoryNodeWidget(
            key: nodes[index].key,
            node: nodes[index],
            dx: 30,
            dy: nodes[index].dy,
          );
        },
      ),
    );
  }
}
