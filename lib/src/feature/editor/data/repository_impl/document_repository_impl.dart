import 'package:dial_editor/src/feature/editor/data/data_source/database_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/data_source/file_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/document_codec.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

/// Implementation of the [DocumentRepository] interface.
///
/// This class provides the concrete implementation for the methods defined
/// in the [DocumentRepository] interface, handling the data operations
/// related to documents.
class DocumentRepositoryImpl implements DocumentRepository {
  /// Implementation of the DocumentRepository interface.
  ///
  /// This class provides methods to interact with and manage documents.
  /// It serves as a bridge between the data layer and the domain layer,
  /// handling data operations related to documents.
  DocumentRepositoryImpl({
    required this.fileLocalDataSource,
    required this.databaseLocalDataSource,
  });

  /// A data source for handling local file operations.
  ///
  /// This is used to interact with the local file system for reading and 
  /// writing
  /// document data.
  final FileLocalDataSource fileLocalDataSource;

  /// A repository implementation for handling document-related operations.
  ///
  /// This class interacts with the local database data source to perform
  /// CRUD operations on documents.
  ///
  /// The [databaseLocalDataSource] is used to access the local database
  /// for storing and retrieving document data.
  final DatabaseLocalDataSource databaseLocalDataSource;

  @override
  Future<String> decode(Document input) async {
    final content = DocumentCodec(input.uuid).decode(input);
    return content;
  }

  @override
  Future<Document> encode() {
    final file = fileLocalDataSource.readFile();

    return file.then((value) {
      final uuid = databaseLocalDataSource.getOrCreateUuidForFile(value);
      return uuid.then((value2) {
        if (value2.$2) {
          return databaseLocalDataSource.fetchDocument(value2.$1);
        } else {
          final input = value.readAsStringSync();
          final document = DocumentCodec(value2.$1).encode(input);
          databaseLocalDataSource.saveDocument(document);
          return document;
        }
      });
    });
  }

  @override
  Future<void> saveDocumentToFile(String input) {
    return fileLocalDataSource.writeFile(input);
  }

  @override
  Future<Document> fetchDocumentFromDatabase(String uuid) async {
    return databaseLocalDataSource.fetchDocument(uuid);
  }

  @override
  Future<List<Document>> fetchAllDocumentsFromDatabase() async {
    return databaseLocalDataSource.fetchAllDocuments();
  }

  @override
  Future<void> saveDocumentToDatabase(Document input) {
    return databaseLocalDataSource.saveDocument(input);
  }
}
