import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class GetDocumentUseCase {
  final DocumentRepository repository;

  GetDocumentUseCase(this.repository);

  Future<Document> call() async {
    return await repository.encode();
  }
}
