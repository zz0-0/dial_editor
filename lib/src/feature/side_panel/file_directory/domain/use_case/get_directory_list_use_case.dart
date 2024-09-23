import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/repository/directory_repository.dart';

/// A use case class responsible for retrieving the list of directories.
///
/// This class provides the functionality to fetch and manage the list of
/// directories from the specified source. It encapsulates the logic required
/// to interact with the data layer and retrieve the necessary directory
/// information.
class GetDirectoryListUseCase {
  /// Initializes the use case with the provided directory repository.
  GetDirectoryListUseCase(this.repository);

  /// A directory repository to fetch the directory list from.
  final DirectoryRepository repository;

  /// Retrieves a list of directory nodes.
  ///
  /// This use case is responsible for fetching the list of directory nodes
  /// asynchronously. It returns a `Future` that completes with a list of 
  /// `DirectoryNode` objects.
  Future<List<DirectoryNode>> call() async {
    return repository.getDirectory();
  }
}
