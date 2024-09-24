import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class GetAllDocumentElementUseCase {
  GetAllDocumentElementUseCase(this.repository);
  final DocumentRepository repository;
  Future<List<Document>> call() async {
    return repository.fetchAllDocumentsFromDatabase();
  }
}
