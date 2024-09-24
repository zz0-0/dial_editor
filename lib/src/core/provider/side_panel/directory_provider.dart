import 'package:dial_editor/src/feature/side_panel/file_directory/data/data_source/directory_local_data_source.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/data/repository_impl/directory_repository_impl.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/use_case/get_directory_list_use_case.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/presentation/view_model/directory_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final directoryRepositoryProvider = FutureProvider((ref) {
  final directoryLocalDataSource = DirectoryLocalDataSourceImpl(ref);
  return DirectoryRepositoryImpl(
    localDataSource: directoryLocalDataSource,
  );
});
final getDirectoryListUseCaseProvider = FutureProvider((ref) async {
  final repository = await ref.watch(directoryRepositoryProvider.future);
  return GetDirectoryListUseCase(repository);
});
final directoryViewModelProvider =
    StateNotifierProvider<DirectoryViewModel, List<DirectoryNode>>(
  (ref) {
    return DirectoryViewModel(ref);
  },
);
final openFileProvider = Provider((ref) async {
  final repository = await ref.watch(directoryRepositoryProvider.future);
  return repository.getFileSystemEntity();
});
final createNewFileProvider = Provider((ref) async {
  final repository = await ref.watch(directoryRepositoryProvider.future);
  return repository.createNewFile();
});
final indentationProvider = Provider((ref) => 40);
final iconSizeProvider = Provider((ref) => 40);
final directoryNodeExpandedProvider =
    StateProvider.family<bool, Key>((ref, arg) => false);
