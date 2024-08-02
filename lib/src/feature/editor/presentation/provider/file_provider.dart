import 'package:dial_editor/src/feature/editor/data/datasource/local_file_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/file_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fileDataSourceProvider = Provider((ref) => LocalfiledatasourceImpl());

final fileRepositoryProvider = Provider((ref) {
  final Localfiledatasource localfiledatasource =
      ref.watch(fileDataSourceProvider);
  return FileRepositoryImpl(localfiledatasource);
});

final fileProvider =
    FutureProvider((ref) => ref.watch(fileRepositoryProvider).getFile());
