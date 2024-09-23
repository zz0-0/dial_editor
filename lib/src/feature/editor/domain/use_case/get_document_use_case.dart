import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

/// A use case class responsible for retrieving a document.
///
/// This class defines the business logic for fetching a document
/// from a repository or data source. It encapsulates the necessary
/// operations to obtain the document data, ensuring that the
/// presentation layer remains decoupled from the data layer.
class GetDocumentUseCase {
  /// A use case for retrieving a document from the repository.
  ///
  /// This class is responsible for fetching a document using the provided
  /// repository.
  ///
  /// Example usage:
  /// ```dart
  /// final useCase = GetDocumentUseCase(repository);
  /// final document = await useCase.execute(documentId);
  /// ```
  ///
  /// The [repository] parameter is required to interact with the data source.
  GetDocumentUseCase(this.repository);

  /// A use case class responsible for retrieving documents from the repository.
  ///
  /// This class interacts with the [DocumentRepository] to fetch documents
  /// based on specific criteria or identifiers.
  final DocumentRepository repository;

  /// Asynchronously retrieves a `Document`.
  ///
  /// This method performs the necessary operations to fetch and return
  /// a `Document` object. The exact implementation details depend on
  /// the specific use case and data source.
  ///
  /// Returns:
  ///   A `Future` that completes with a `Document` object.
  Future<Document> call() async {
    return repository.encode();
  }
}
