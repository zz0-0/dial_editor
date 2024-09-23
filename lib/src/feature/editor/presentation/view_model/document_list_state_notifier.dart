import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A state notifier that manages a list of `Document` objects.
///
/// This class extends `StateNotifier` and is responsible for handling the state
/// of a list of documents. It provides methods to manipulate the list
/// and notify
/// listeners of any changes.
///
/// The state is represented as a list of `Document` objects.
class DocumentListStateNotifier extends StateNotifier<List<Document>> {
  /// A state notifier for managing the list of documents.
  ///
  /// This class extends the `StateNotifier` with an initial empty list
  /// of documents.
  /// It uses a reference to manage and notify changes in the document
  /// list state.
  ///
  /// The `DocumentListStateNotifier` is responsible for handling the
  /// state of the
  /// document list within the application.
  ///
  /// - Parameter ref: A reference used to manage and notify state changes.
  DocumentListStateNotifier(this.ref) : super([]) {
    getList();
  }

  /// A reference to the provider's state and other utilities.
  ///
  /// This is used to interact with the state management system, allowing
  /// the notifier to read and manipulate the state of the application.
  Ref ref;

  /// Asynchronously retrieves a list of documents.
  ///
  /// This method fetches the list of documents and updates the state
  /// accordingly.
  /// It performs the necessary asynchronous operations to obtain the data.
  ///
  /// Throws:
  /// - [Exception] if there is an error during the retrieval process.
  ///
  /// Example usage:
  /// ```dart
  /// await getList();
  /// ```
  Future<void> getList() async {
    final getAllDocumentElementUseCase =
        await ref.read(getAllDocumentElementUseCaseProvider.future);
    final documents = await getAllDocumentElementUseCase();
    state = documents;
  }
}
