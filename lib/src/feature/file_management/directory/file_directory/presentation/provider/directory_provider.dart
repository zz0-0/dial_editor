import 'dart:io';

import 'package:dial_editor/src/feature/file_management/directory/file_directory/data/data_source/directory_local_data_source.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/data/data_source/directory_remote_data_source.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/data/repository_impl/directory_repository_impl.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/provider/directory_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// presentation layer cannot use
final directoryLocalDataSourceProvider = Provider(
  (ref) => DirectoryLocalDataSourceImpl(),
);

final directoryRemoteDataSourceProvider = Provider(
  (ref) => DirectoryRemoteDataSourceImpl(),
);

final directoryNodeListRepositoryProvider = FutureProvider((ref) {
  final directoryLocalDataSource = ref.watch(directoryLocalDataSourceProvider);
  final directoryRemoteDataSource =
      ref.watch(directoryRemoteDataSourceProvider);
  return DirectoryRepositoryImpl(
    remoteDataSource: directoryRemoteDataSource,
    localDataSource: directoryLocalDataSource,
  ).getDirectory();
});

// presentation layer can use
final directoryNodeListProvider =
    StateNotifierProvider<DiretoryNotifier, List<DirectoryNode>>(
  (ref) {
    final watch = ref.watch(directoryNodeListRepositoryProvider);
    return DiretoryNotifier(watch);
  },
);
final indentationProvider = Provider((ref) => 40);
final iconSizeProvider = Provider((ref) => 40);
final directoryNodeExpandedProvider =
    StateProvider.family<bool, Key>((ref, arg) => false);

final fileProvider = StateProvider<File?>((ref) => null);
final directoryNodeListHasDataProvider = Provider((ref) {
  if (ref.watch(directoryNodeListProvider) != []) {
    return true;
  } else {
    return false;
  }
});
