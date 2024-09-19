import 'dart:io';

import 'package:dial_editor/src/core/provider/router/router_provider.dart';
import 'package:dial_editor/src/core/provider/side_panel/directory_provider.dart';
import 'package:dial_editor/src/core/provider/ui/editor_provder.dart';
import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:dial_editor/src/core/provider/ui/top_bar_provider.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/main_area/editor/tab_part.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/side_panel/file_directory/empty_directory.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/side_panel/file_directory/file_directory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileBranch extends ConsumerWidget {
  const FileBranch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ref.read(isDesktopProvider);
    if (ref.watch(openFolderProvider)) {
      if (isDesktop) {
        return Scaffold(
          body: Row(
            children: [
              if (ref.watch(fileSidePanelProvider)) const FileDirectory(),
              if (ref.watch(fileSidePanelProvider))
                const VerticalDivider(thickness: 1, width: 1),
              if (ref.watch(fileProvider) != null)
                const Expanded(child: TabPart()),
            ],
          ),
        );
      } else {
        return Scaffold(
          body: Row(
            children: [
              if (ref.watch(fileProvider) != null)
                const Expanded(child: TabPart()),
            ],
          ),
        );
      }
    } else {
      if (isDesktop) {
        return Scaffold(
          body: Row(
            children: [
              if (ref.watch(fileEmptySidePanelProvider)) const EmptyDirectory(),
              if (ref.watch(fileEmptySidePanelProvider))
                const VerticalDivider(thickness: 1, width: 1),
              const Expanded(child: Center(child: Text("Dial Editor"))),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ref.read(openFolderProvider.notifier).update((state) => true);
              ref.read(openFileProvider);
            },
            child: const Icon(Icons.folder_open),
          ),
        );
      } else {
        return Scaffold(
          body: Row(
            children: [
              if (ref.watch(fileProvider) == null)
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final file = await ref.read(openFileProvider);
                      ref
                          .read(fileProvider.notifier)
                          .update((state) => file as File);
                      ref
                          .read(openFolderProvider.notifier)
                          .update((state) => true);
                      ref.read(openedFilesProvider.notifier).addFile(file.path);
                    },
                    child: const Text("Open File"),
                  ),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ref.read(createNewFileProvider);
              ref.read(openFolderProvider.notifier).update((state) => true);
            },
            child: const Icon(Icons.folder_open),
          ),
        );
      }
    }
  }
}
