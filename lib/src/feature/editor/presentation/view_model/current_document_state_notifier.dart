import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/document.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A state notifier that manages the current state of a document.
///
/// This class extends [StateNotifier] and is responsible for handling the
/// state of a [Document?]. It provides methods to update and manage the
/// document state within the application.
class CurrentDocumentStateNotifier extends StateNotifier<Document?> {
  /// A notifier class that manages the state of the current document.
  ///
  /// This class extends a state notifier and is responsible for handling
  /// the state of the current document within the editor feature.
  ///
  /// The constructor initializes the notifier with a reference to the
  /// provider's ref object.
  ///
  /// @param ref A reference to the provider's ref object.
  CurrentDocumentStateNotifier(this.ref) : super(null) {
    getDocument();
  }

  /// A reference to the provider container, allowing access to other providers
  /// and their states within the application.
  Ref ref;

  /// Asynchronously retrieves the current document.
  ///
  /// This method fetches the document data and updates the state accordingly.
  /// It performs necessary asynchronous operations to ensure the document
  /// is loaded properly.
  ///
  /// Throws:
  /// - [Exception] if there is an error during the document retrieval process.
  ///
  /// Returns:
  /// A [Future] that completes when the document has been successfully
  /// retrieved.
  Future<void> getDocument() async {
    final getDocumentUseCase =
        await ref.read(getDocumentUseCaseProvider.future);
    final document = await getDocumentUseCase();
    state = document;
  }
}
