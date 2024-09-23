import 'package:dial_editor/src/core/provider/side_panel/directory_provider.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/presentation/widget/directory_node_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents a directory in the file system.
///
/// This widget is a consumer widget that listens to changes in the
/// provider and rebuilds accordingly. It is used within the side
/// panel of the application to display the file directory structure.
class Directory extends ConsumerWidget {
  /// A widget that represents a directory in the file directory side panel.
  ///
  /// This widget is used to display and manage the contents of a directory
  /// within the side panel of the application.
  ///
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
