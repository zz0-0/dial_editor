import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class LinkNodesUseCase {
  LinkNodesUseCase(this.repository);
  final DocumentRepository repository;
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
