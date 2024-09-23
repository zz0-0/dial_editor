import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

/// A use case class responsible for retrieving all document elements.
///
/// This class provides the functionality to fetch all elements within a
/// document,
/// which can be used for various purposes such as displaying, editing, or
/// processing
/// the document's content.
///
/// Example usage:
///
/// ```dart
/// final useCase = GetAllDocumentElementUseCase();
/// final elements = useCase.execute();
/// ```
///
/// Note: Ensure that the necessary dependencies and data sources are properly
/// initialized before using this use case.
class GetAllDocumentElementUseCase {
  /// A use case class responsible for retrieving all document elements from
  /// the repository.
  ///
  /// This class interacts with the repository to fetch all elements of a
  /// document.
  ///
  /// Example usage:
  /// ```dart
  /// final useCase = GetAllDocumentElementUseCase(repository);
  /// final elements = useCase.execute();
  /// ```
  ///
  /// @param repository The repository instance used to fetch document elements.
  GetAllDocumentElementUseCase(this.repository);

  /// A use case class that retrieves all document elements from the repository.
  ///
  /// This class interacts with the [DocumentRepository] to fetch all elements
  /// of a document. It serves as an intermediary between the domain layer and
  /// the data layer, ensuring that the business logic is decoupled from the
  /// data access logic.
  ///
  /// The [repository] is an instance of [DocumentRepository] that provides
  /// methods to access document data.
  final DocumentRepository repository;

  /// Retrieves all document elements.
  ///
  /// This use case is responsible for fetching a list of all document elements.
  ///
  /// Returns a [Future] that completes with a list of [Document] objects.
  Future<List<Document>> call() async {
    return repository.fetchAllDocumentsFromDatabase();
  }
}
