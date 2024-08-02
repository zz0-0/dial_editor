import 'package:dial_editor/src/feature/sidepanel/file_directory/data/data_source/directory_local_data_source.dart';
import 'package:dial_editor/src/feature/sidepanel/file_directory/data/data_source/directory_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final directoryLocalDataSourceProvider = Provider(
  (ref) => DirectoryLocalDataSourceImpl(),
);
final directoryRemoteDataSourceProvider = Provider(
  (ref) => DirectoryRemoteDataSourceImpl(),
);
