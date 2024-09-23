import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A state notifier that manages a list of file metadata.
///
/// This class extends `StateNotifier` and is responsible for handling the state
/// of a list of `FileMetadata` objects. It provides methods to manipulate and
/// update the state, ensuring that the UI reflects the current state of the
/// file
/// metadata.
///
/// The state is represented as a list of `FileMetadata` objects, which can be
/// accessed and modified through the methods provided by this class.
///
/// Example usage:
///
/// ```dart
/// final fileMetadataNotifier = FileMetadataStateNotifer();
/// fileMetadataNotifier.add(FileMetadata(...));
/// ```
///
/// See also:
///
/// * [StateNotifier], which this class extends.
/// * [FileMetadata], the type of objects managed by this notifier.
class FileMetadataStateNotifer extends StateNotifier<List<FileMetadata>> {
  /// Constructs a [FileMetadataStateNotifer] instance.
  ///
  /// Initializes the state notifier with the provided [ref] and [uuid].
  /// Calls the super constructor with an empty list.
  ///
  /// - Parameters:
  ///   - ref: A reference to the required dependency.
  ///   - uuid: A unique identifier for the file metadata.
  FileMetadataStateNotifer(this.ref, this.uuid) : super([]) {
    getFileMetadata();
  }

  /// A reference to the provider's container.
  ///
  /// This is used to access and interact with other providers within the
  /// application. It allows for dependency injection and state management.
  ///
  /// Example usage:
  /// ```dart
  /// final someProvider = ref.read(someProvider);
  /// ```
  Ref ref;

  /// A unique identifier for the file metadata.
  /// This UUID is used to uniquely identify each file metadata instance.
  String uuid;

  /// Asynchronously retrieves the metadata for a file.
  ///
  /// This method fetches and processes the metadata associated with a file.
  /// It performs the necessary asynchronous operations to obtain the metadata
  /// and updates the relevant state accordingly.
  ///
  /// Throws:
  /// - [Exception] if there is an error during the metadata retrieval process.
  ///
  /// Usage:
  /// ```dart
  /// await getFileMetadata();
  /// ```
  Future<void> getFileMetadata() async {
    final metadata = <FileMetadata>[];
    final getFileMetadataUseCase =
        await ref.read(getFileMetadataUseCaseProvider.future);
    final data = await getFileMetadataUseCase(uuid);
    metadata.add(data);
    state = metadata;
  }
}
