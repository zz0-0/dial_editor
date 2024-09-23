import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

/// A use case class responsible for handling operations related to link nodes
/// within the editor domain.
///
/// This class provides methods to manage and manipulate link nodes, ensuring
/// that they are correctly integrated and functional within the editor.
class LinkNodesUseCase {
  /// A use case for handling link nodes in the editor domain.
  ///
  /// This use case interacts with the repository to manage link nodes.
  ///
  /// @param repository The repository instance used for managing link nodes.
  LinkNodesUseCase(this.repository);

  /// A repository that provides access to document-related operations.
  ///
  /// This repository is used to perform various actions on documents,
  /// such as fetching, updating, and deleting document data.
  final DocumentRepository repository;

  /// Links nodes together based on the provided logic.
  ///
  /// This function performs the necessary operations to establish connections
  /// between nodes in the editor domain. The specific details of the linking
  /// process depend on the implementation.
  ///
  ///
  /// Example:
  /// ```dart
  /// await linkNodes();
  /// ```
  ///
  /// Returns a [Future] that completes when the linking process is finished.
  Future<void> linkNodes(
    String sourceDocumentUuid,
    String targetDocumentUuid,
    String sourceNodeKey,
    String targetNodeKey,
  ) async {
    final document =
        await repository.fetchDocumentFromDatabase(sourceDocumentUuid);
    document.addBidirectionalLink(
      targetDocumentUuid,
      sourceNodeKey,
      targetNodeKey,
    );
    await repository.saveDocumentToDatabase(document);
  }

  /// Unlinks nodes in the editor.
  ///
  /// This method removes the link between nodes, effectively isolating them.
  ///
  /// Returns a [Future] that completes when the nodes have been unlinked.
  Future<void> unlinkNodes(
    String sourceDocumentUuid,
    String sourceNodeKey,
    String connectionKey,
  ) async {
    final document =
        await repository.fetchDocumentFromDatabase(sourceDocumentUuid);
    document.removeBidirectionalLink(sourceNodeKey, connectionKey);
    await repository.saveDocumentToDatabase(document);
  }
}
