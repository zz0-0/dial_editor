import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class GetDocumentChildrenUseCase {
  final DocumentRepository _documentRepository;

  GetDocumentChildrenUseCase(this._documentRepository);

  Future<List<Node>> getChildren() async {
    final document = await _documentRepository.encode();
    return document.getNodesInOrder();
  }
}
