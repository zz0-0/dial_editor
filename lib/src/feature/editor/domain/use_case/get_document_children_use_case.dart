import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class GetDocumentChildrenUseCase {
  final DocumentRepository _documentRepository;

  GetDocumentChildrenUseCase(this._documentRepository);

  List<Node> getChildren() {
    return _documentRepository.encode().children;
  }
}
