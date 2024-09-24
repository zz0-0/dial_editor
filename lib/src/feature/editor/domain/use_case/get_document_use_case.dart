import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class GetDocumentUseCase {
  GetDocumentUseCase(this.repository);
  final DocumentRepository repository;
  Future<Document> call() async {
    return repository.encode();
  }
}
