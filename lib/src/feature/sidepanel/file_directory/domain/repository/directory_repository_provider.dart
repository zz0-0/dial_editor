import 'package:dial_editor/src/feature/sidepanel/file_directory/data/data_source/directory_data_source_provider.dart';
import 'package:dial_editor/src/feature/sidepanel/file_directory/data/repository_impl/directory_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final directoryNodeListRepositoryProvider = FutureProvider((ref) {
  final directoryLocalDataSource = ref.watch(directoryLocalDataSourceProvider);
  final directoryRemoteDataSource =
      ref.watch(directoryRemoteDataSourceProvider);
  return DirectoryRepositoryImpl(
    remoteDataSource: directoryRemoteDataSource,
    localDataSource: directoryLocalDataSource,
  ).getDirectory();
});
