import 'dart:io';
import 'package:dial_editor/src/core/provider/side_panel/directory_provider.dart';
import 'package:dial_editor/src/core/provider/ui/editor_provder.dart';
import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectoryNodeViewModel extends StateNotifier<void> {
  DirectoryNodeViewModel() : super(null);
  void expandNode(WidgetRef ref, Key key) {
    ref.read(directoryNodeExpandedProvider(key).notifier).update((state) {
      if (state) {
        return false;
      } else {
        return true;
      }
    });
  }

  void openFile(WidgetRef ref, DirectoryNode node) {
    final file = File(node.path!);
    ref.read(fileProvider.notifier).update((state) => file);
    ref.read(openedFilesProvider.notifier).addFile(node.path!);
  }
}
