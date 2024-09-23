import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/file_meta_repository.dart';

/// A use case class responsible for retrieving metadata of a file.
///
/// This class provides functionality to fetch and handle metadata
/// associated with a specific file, which can include information
/// such as file size, creation date, modification date, and more.
///
/// Usage:
/// ```dart
/// final useCase = GetFileMetadataUseCase();
/// final metadata = useCase.execute(filePath);
/// ```
///
/// Note: Ensure that the file path provided is valid and accessible.
class GetFileMetadataUseCase {
  /// A use case class responsible for retrieving file metadata.
  ///
  /// This class interacts with the repository to fetch metadata information
  /// about a file.
  ///
  /// Example usage:
  /// ```dart
  /// final useCase = GetFileMetadataUseCase(repository);
  /// final metadata = await useCase.execute(fileId);
  /// ```
  ///
  /// @param repository The repository instance used to fetch file metadata.
  GetFileMetadataUseCase(this.repository);

  /// A repository that provides access to file metadata.
  final FileMetaRepository repository;

  /// Retrieves the metadata for a file based on the provided UUID.
  ///
  /// This method fetches and returns the [FileMetadata] associated with the
  /// given [uuid]. The [uuid] is a unique identifier for the file whose
  /// metadata is being requested.
  ///
  /// Returns a [Future] that completes with the [FileMetadata] of the file.
  ///
  /// [uuid]: The unique identifier of the file.
  Future<FileMetadata> call(String uuid) {
    return repository.fetchFileMetadataFromDatabase(uuid);
  }
}
