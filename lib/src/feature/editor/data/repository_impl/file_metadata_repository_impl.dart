import 'package:dial_editor/src/feature/editor/data/data_source/database_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/file_meta_repository.dart';

class FileMetadataRepositoryImpl extends FileMetaRepository {
  final DatabaseLocalDataSource databaseLocalDataSource;

  FileMetadataRepositoryImpl({
    required this.databaseLocalDataSource,
  });

  @override
  Future<FileMetadata> fetchFileMetadataFromDatabase(String uuid) {
    return databaseLocalDataSource.fetchFileMetadata(uuid);
  }
}
