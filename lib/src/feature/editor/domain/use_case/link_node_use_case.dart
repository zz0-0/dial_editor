import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class LinkNodesUseCase {
  final DocumentRepository documentRepository;

  LinkNodesUseCase(this.documentRepository);

  Future<void> linkNodes(
    String sourceDocumentUuid,
    String targetDocumentUuid,
    String sourceNodeKey,
    String targetNodeKey,
  ) async {
    final document =
        await documentRepository.fetchDocumentFromDatabase(sourceDocumentUuid);
    document.addBidirectionalLink(
      targetDocumentUuid,
      sourceNodeKey,
      targetNodeKey,
    );
    await documentRepository.saveDocumentToDatabase(document);
  }

  Future<void> unlinkNodes(
    String sourceDocumentUuid,
    String sourceNodeKey,
    String connectionKey,
  ) async {
    final document =
        await documentRepository.fetchDocumentFromDatabase(sourceDocumentUuid);
    document.removeBidirectionalLink(sourceNodeKey, connectionKey);
    await documentRepository.saveDocumentToDatabase(document);
  }
}
