import 'package:dial_editor/src/feature/editor/data/data_source/database_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/file_meta_repository.dart';

/// Implementation of the [FileMetaRepository] interface.
///
/// This class provides methods to handle file metadata operations.
/// It serves as a concrete implementation of the repository pattern
/// for managing file metadata.
class FileMetadataRepositoryImpl extends FileMetaRepository {
  /// Implementation of the `FileMetadataRepository` interface.
  ///
  /// This class provides methods to handle file metadata operations.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// final repository = FileMetadataRepositoryImpl();
  /// // Use repository to perform file metadata operations
  /// ```
  ///
  /// {@category Repository}
  FileMetadataRepositoryImpl({
    required this.databaseLocalDataSource,
  });

  /// A repository implementation for handling file metadata operations.
  ///
  /// This class interacts with the local database to perform CRUD operations
  /// related to file metadata.
  ///
  /// Dependencies:
  /// - [DatabaseLocalDataSource]: The data source for accessing the local
  /// database.
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
