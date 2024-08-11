import 'package:dial_editor/src/feature/side_panel/file_directory/data/data_source/directory_local_data_source.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/data/repository_impl/directory_repository_impl.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/presentation/view_model/directory_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final directoryNodeListRepositoryProvider = FutureProvider((ref) {
  final directoryLocalDataSource = DirectoryLocalDataSourceImpl();
  return DirectoryRepositoryImpl(
    localDataSource: directoryLocalDataSource,
  ).getDirectory();
});

final directoryNodeListProvider =
    StateNotifierProvider<DirectoryViewModel, List<DirectoryNode>>(
  (ref) {
    final watch = ref.watch(directoryNodeListRepositoryProvider);
    return DirectoryViewModel(watch);
  },
);

final directoryNodeListHasDataProvider = Provider((ref) {
  if (ref.watch(directoryNodeListProvider) != []) {
    return true;
  } else {
    return false;
  }
});

final indentationProvider = Provider((ref) => 40);
final iconSizeProvider = Provider((ref) => 40);
final directoryNodeExpandedProvider =
    StateProvider.family<bool, Key>((ref, arg) => false);
