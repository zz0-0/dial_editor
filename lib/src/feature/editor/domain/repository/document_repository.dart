import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

/// An abstract class that defines the contract for a document repository.
///
/// This repository is responsible for handling operations related to documents,
/// such as fetching, saving, updating, and deleting documents. Implementations
/// of this repository should provide the concrete logic for these operations.
abstract class DocumentRepository {
  /// Encodes the current document into a specific format.
  ///
  /// This method is responsible for converting the document into a format
  /// that can be stored or transmitted. The exact format and encoding
  /// mechanism are determined by the implementation.
  ///
  /// Returns a [Future] that completes with the encoded [Document].
  Future<Document> encode();

  /// Decodes the given [Document] input and returns a [String] representation.
  ///
  /// This method takes a [Document] object as input and processes it to produce
  /// a decoded string. The exact decoding process depends on the implementation
  /// details of the method.
  ///
  /// - Parameter input: The [Document] object to be decoded.
  /// - Returns: A [Future] that completes with the decoded [String]
  /// representation
  ///   of the input document.
  Future<String> decode(Document input);

  /// Saves the provided document content to a file.
  ///
  /// This method takes a string input representing the document content
  /// and saves it to a file. The exact file path and handling are
  /// determined by the implementation.
  ///
  /// [input] The content of the document to be saved.
  ///
  Future<void> saveDocumentToFile(String input);

  /// Fetches a document from the database using the provided UUID.
  ///
  /// This method retrieves a [Document] object from the database
  /// corresponding to the given [uuid].
  ///
  /// [uuid] is a unique identifier for the document to be fetched.
  ///
  /// Returns a [Future] that completes with the fetched [Document].
  Future<Document> fetchDocumentFromDatabase(String uuid);

  /// Fetches all documents from the database.
  ///
  /// This method retrieves a list of [Document] objects from the database.
  ///
  /// Returns a [Future] that completes with a list of [Document] objects.
  Future<List<Document>> fetchAllDocumentsFromDatabase();

  /// Saves the given document to the database.
  ///
  /// This method takes a [Document] object as input and saves it to the
  /// database. The operation is performed asynchronously.
  ///
  /// [input] - The document to be saved.
  ///
  /// Returns a [Future] that completes when the document has been saved.
  Future<void> saveDocumentToDatabase(Document input);
}
