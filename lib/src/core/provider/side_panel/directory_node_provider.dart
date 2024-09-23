import 'package:dial_editor/src/feature/side_panel/file_directory/presentation/view_model/directory_node_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider for the `DirectoryNodeViewModel`.
///
/// This provider is responsible for managing the state and logic related to
/// the directory node view model within the side panel of the application.
/// It ensures that the view model is available for use throughout the
/// application where needed.
final directoryNodeViewModelProvider =
    StateNotifierProvider<DirectoryNodeViewModel, void>(
  (ref) => DirectoryNodeViewModel(),
);
