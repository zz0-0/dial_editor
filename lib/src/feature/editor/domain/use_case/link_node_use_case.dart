import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';
import 'package:flutter/material.dart';

class LinkNodesUseCase {
  final DocumentRepository documentRepository;

  LinkNodesUseCase(this.documentRepository);

  Future<void> linkNodes(
    GlobalKey sourceDocumentKey,
    GlobalKey targetDocumentKey,
    GlobalKey sourceNodeKey,
    GlobalKey targetNodeKey,
  ) async {
    final document =
        await documentRepository.fetchDocumentFromDatabase(sourceDocumentKey);
    document.addBidirectionalLink(
      targetDocumentKey,
      sourceNodeKey,
      targetNodeKey,
    );
    await documentRepository.saveDocumentToDatabase(document);
  }

  Future<void> unlinkNodes(
    GlobalKey sourceDocumentKey,
    GlobalKey sourceNodeKey,
    GlobalKey connectionKey,
  ) async {
    final document =
        await documentRepository.fetchDocumentFromDatabase(sourceDocumentKey);
    document.removeBidirectionalLink(sourceNodeKey, connectionKey);
    await documentRepository.saveDocumentToDatabase(document);
  }
}
