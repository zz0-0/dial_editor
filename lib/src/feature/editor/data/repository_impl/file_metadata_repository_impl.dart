import 'package:dial_editor/src/feature/editor/data/data_source/database_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/file_meta_repository.dart';

class FileMetadataRepositoryImpl extends FileMetaRepository {
  FileMetadataRepositoryImpl({
    required this.databaseLocalDataSource,
  });
  final DatabaseLocalDataSource databaseLocalDataSource;
  @override
  Future<FileMetadata> fetchFileMetadataFromDatabase(String uuid) {
    return databaseLocalDataSource.fetchFileMetadata(uuid);
  }

  @override
  Future<void> saveFileMetadataToDatabase(FileMetadata fileMetadata) {
    // TODO(get): implement saveFileMetadataToDatabase
    throw UnimplementedError();
  }
}
