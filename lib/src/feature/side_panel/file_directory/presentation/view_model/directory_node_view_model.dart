import 'dart:io';

import 'package:dial_editor/src/core/provider/side_panel/directory_provider.dart';
import 'package:dial_editor/src/core/provider/ui/editor_provder.dart';
import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A view model class that extends `StateNotifier<void>` to manage the state
/// of a directory node in the file directory side panel.
///
/// This class is responsible for handling the state and logic related to
/// directory nodes, which are part of the file directory structure in the
/// side panel of the application.
class DirectoryNodeViewModel extends StateNotifier<void> {
  /// A view model for representing a directory node in the file directory side
  /// panel.
  ///
  /// This class extends a base view model and initializes it with a null value.
  DirectoryNodeViewModel() : super(null);

  /// Expands the directory node associated with the given key.
  ///
  /// This method updates the state of the directory node to reflect that it is
  /// expanded. It uses the provided [WidgetRef] to access and modify the state.
  ///
  /// - Parameters:
  ///   - ref: A reference to the widget's state, used to access and modify the
  ///     directory node's state.
  ///   - key: The key associated with the directory node to be expanded.
  void expandNode(WidgetRef ref, Key key) {
    ref.read(directoryNodeExpandedProvider(key).notifier).update((state) {
      if (state) {
        return false;
      } else {
        return true;
      }
    });
  }

  /// Opens a file represented by the given [DirectoryNode].
  ///
  /// This method uses the provided [WidgetRef] to access the necessary
  /// dependencies and state required to open the file.
  ///
  /// - Parameters:
  ///   - ref: A reference to the widget's state and dependencies.
  ///   - node: The directory node representing the file to be opened.
  void openFile(WidgetRef ref, DirectoryNode node) {
    final file = File(node.path!);
    ref.read(fileProvider.notifier).update((state) => file);
    ref.read(openedFilesProvider.notifier).addFile(node.path!);
  }
}
