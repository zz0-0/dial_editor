import 'package:dial_editor/src/core/markdown_element.dart';

abstract class DocumentRepository {
  Future<Document> encode();
  Future<String> decode(Document input);
  Future<void> saveDocumentToFile(String input);
  Future<Document> fetchDocumentFromDatabase(String uuid);
  Future<List<Document>> fetchAllDocumentsFromDatabase();
  Future<void> saveDocumentToDatabase(Document input);
}
