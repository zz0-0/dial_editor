import 'package:dial_editor/src/feature/core/presentation/widget/sidepanel/side_panel_provider.dart';
import 'package:dial_editor/src/feature/core/presentation/widget/topbar/top_bar_provider.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/domain/model/directory_node_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmptyDirectory extends ConsumerStatefulWidget {
  const EmptyDirectory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmptyDirectoryState();
}

class _EmptyDirectoryState extends ConsumerState<EmptyDirectory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              ref.read(directoryNodeListProvider.notifier).openFolder;
              ref
                  .read(fileEmptySidePanelProvider.notifier)
                  .update((state) => false);
              ref.read(openFolderProvider.notifier).update((state) => true);
              ref.read(fileSidePanelProvider.notifier).update((state) => true);
            },
            child: const Text("Open Folder"),
          ),
        ],
      ),
    );
  }
}
