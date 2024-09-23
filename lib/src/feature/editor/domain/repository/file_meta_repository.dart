import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';

/// An abstract class that defines the contract for a repository
/// responsible for handling file metadata operations.
///
/// Implementations of this repository should provide methods to
/// perform CRUD operations on file metadata, ensuring that the
/// necessary data is available for the editor feature.
abstract class FileMetaRepository {
  /// Fetches the metadata of a file from the database using the provided UUID.
  ///
  /// This method retrieves the [FileMetadata] associated with the given [uuid].
  ///
  /// [uuid]: A unique identifier for the file whose metadata is to be fetched.
  ///
  /// Returns a [Future] that completes with the [FileMetadata] of the file.
  Future<FileMetadata> fetchFileMetadataFromDatabase(String uuid);
  Future<void> saveFileMetadataToDatabase(FileMetadata fileMetadata);
}
