import 'package:dial_editor/src/feature/side_panel/file_directory/presentation/view_model/directory_node_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final directoryNodeViewModelProvider =
    StateNotifierProvider<DirectoryNodeViewModel, void>(
  (ref) => DirectoryNodeViewModel(),
);
