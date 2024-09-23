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

/// A widget that represents a branch in the file navigation tree.
///
/// This widget is a part of the navigation system in the application,
/// specifically designed to handle and display file branches.
///
/// It extends [ConsumerWidget] to leverage the state management
/// capabilities provided by the Riverpod package.
///
/// Usage:
/// ```dart
/// FileBranch()
/// ```
///
/// Make sure to provide the necessary dependencies and context
/// when using this widget.
class FileBranch extends ConsumerWidget {
  /// A widget that represents a file branch in the navigation tree.
  ///
  /// This widget is used to display a file branch within the navigation
  /// structure of the application. It is a stateless widget that takes
  /// a key as an optional parameter.
  ///
  /// {@tool snippet}
  /// ```dart
  /// FileBranch(
  ///   key: Key('file_branch'),
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///  * [Key], which is used to control the widget's identity.
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
              const Expanded(child: Center(child: Text('Dial Editor'))),
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
                    child: const Text('Open File'),
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
