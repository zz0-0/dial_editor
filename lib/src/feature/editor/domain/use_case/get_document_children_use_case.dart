import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

/// A use case class responsible for retrieving the children of a document.
///
/// This class provides the functionality to fetch and manage the children
/// elements of a document within the domain layer of the application.
///
/// Usage:
/// ```dart
/// final useCase = GetDocumentChildrenUseCase();
/// final children = useCase.execute(documentId);
/// ```
///
/// Methods:
/// - `execute(String documentId)`: Retrieves the children of the specified
/// document.
class GetDocumentChildrenUseCase {
  /// A use case that retrieves the children of a document from the repository.
  ///
  /// This use case is responsible for interacting with the repository to fetch
  /// the children elements of a specified document.
  ///
  /// Example usage:
  /// ```dart
  /// final useCase = GetDocumentChildrenUseCase(repository);
  /// final children = await useCase.execute(documentId);
  /// ```
  ///
  /// The repository should provide the necessary methods to access the document
  /// data.
  ///
  /// Parameters:
  /// - `repository`: The repository that provides access to the document data.
  GetDocumentChildrenUseCase(this.repository);

  /// A use case class that retrieves the children of a document from the
  /// repository.
  ///
  /// This class interacts with the [DocumentRepository] to fetch the children
  /// nodes of a specified document. It serves as an intermediary between the
  /// presentation layer and the data layer, ensuring that the business logic
  /// for fetching document children is encapsulated within this use case.
  ///
  /// The [repository] is an instance of [DocumentRepository] that provides
  /// the necessary methods to access the document data.
  final DocumentRepository repository;

  /// Asynchronously retrieves a list of child nodes.
  ///
  /// This method performs an operation to fetch and return a list of
  /// [Node] objects that represent the children in the document structure.
  ///
  /// Returns a [Future] that completes with a [List] of [Node] objects.
  Future<List<Node>> call() async {
    final document = await repository.encode();
    return document.getNodesInOrder();
  }
}
