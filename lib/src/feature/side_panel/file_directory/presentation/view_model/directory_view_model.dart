import 'package:dial_editor/src/core/provider/side_panel/directory_provider.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A ViewModel that extends `StateNotifier` to manage a list of
/// `DirectoryNode` objects.
/// This class is responsible for handling the state and logic related to the
/// directory structure
/// in the side panel of the application.
class DirectoryViewModel extends StateNotifier<List<DirectoryNode>> {
  /// A ViewModel class for managing the state and behavior of the directory
  /// view.
  ///
  /// This class extends a base class with an initial empty list and takes a
  /// reference
  /// as a parameter to initialize the ViewModel.
  ///
  /// The `DirectoryViewModel` is responsible for handling the logic related
  /// to the
  /// directory view in the side panel of the application.
  ///
  /// - Parameter ref: A reference used to initialize the ViewModel.
  DirectoryViewModel(this.ref) : super([]) {
    getDirectory();
  }

  /// A reference to the provider's container, used to read and manipulate
  /// state.
  ///
  /// This is typically used to access other providers or to perform actions
  /// that require interaction with the provider's state.
  ///
  /// Example usage:
  /// ```dart
  /// final someValue = ref.read(someProvider);
  /// ```
  final Ref ref;

  /// Asynchronously retrieves the directory information.
  ///
  /// This method fetches the directory data and performs necessary
  /// operations to update the state of the application accordingly.
  ///
  /// Throws an exception if the directory retrieval fails.
  ///
  /// Usage:
  /// ```dart
  /// await getDirectory();
  /// ```
  ///
  /// Returns a [Future] that completes when the directory information
  /// has been successfully retrieved.
  Future<void> getDirectory() async {
    final getDirectoryListUseCase =
        await ref.read(getDirectoryListUseCaseProvider.future);
    state = await getDirectoryListUseCase();
  }
}
