import 'dart:io';

import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:uuid/uuid.dart';

/// An abstract class that defines the contract for a local data source
/// interacting with the database. Implementations of this class should
/// provide concrete methods to perform CRUD operations on the local database.
abstract class DatabaseLocalDataSource {
  /// Opens the database metadata.
  ///
  /// This method is responsible for opening and returning the database
  /// metadata. It returns a [Future] that completes with the [Database]
  /// instance.
  ///
  /// Returns:
  ///   A [Future] that completes with the [Database] instance.
  Future<Database> openDatabaseMetadata();

  /// Opens the database document.
  ///
  /// This method is responsible for opening a connection to the database
  /// document and returning an instance of the [Database].
  ///
  /// Returns a [Future] that completes with the [Database] instance.
  Future<Database> openDatabaseDocument();

  /// Retrieves or creates a UUID for the given file.
  ///
  /// If the file already has an associated UUID, it returns the UUID and a
  /// boolean indicating that the UUID was not newly created. If the file
  /// does not have an associated UUID, it generates a new UUID, associates
  /// it with the file, and returns the new UUID along with a boolean
  /// indicating that the UUID was newly created.
  ///
  /// [file] The file for which to retrieve or create a UUID.
  ///
  /// Returns a tuple containing the UUID as a [String] and a [bool]
  /// indicating whether the UUID was newly created.
  Future<(String, bool)> getOrCreateUuidForFile(File file);

  /// Fetches a document from the local database using the provided UUID.
  ///
  /// This method retrieves a [Document] object that corresponds to the given
  /// unique identifier (UUID). If the document is found, it is returned as a
  /// [Future] that completes with the [Document]. If the document is not found,
  /// the [Future] may complete with an error or null, depending on the 
  /// implementation.
  ///
  /// - Parameter uuid: The unique identifier of the document to be fetched.
  /// - Returns: A [Future] that completes with the fetched [Document].
  Future<Document> fetchDocument(String uuid);

  /// Fetches all documents from the local database.
  ///
  /// Returns a [Future] that completes with a list of [Document] objects.
  ///
  /// Throws an exception if there is an error during the fetch operation.
  Future<List<Document>> fetchAllDocuments();

  /// Fetches the metadata for a file based on the provided UUID.
  ///
  /// This method retrieves the metadata information for a file identified by
  /// the given UUID. The metadata includes details such as the file's name,
  /// size, creation date, and other relevant attributes.
  ///
  /// [uuid] The unique identifier of the file whose metadata is to be fetched.
  ///
  /// Returns a [Future] that completes with the [FileMetadata] of the file.
  Future<FileMetadata> fetchFileMetadata(String uuid);

  /// Saves the given document to the local database.
  ///
  /// This method takes a [Document] object and stores it in the local
  /// database for later retrieval. It returns a [Future] that completes
  /// when the document has been successfully saved.
  ///
  /// [document]: The document to be saved.
  Future<void> saveDocument(Document document);

  /// Deletes a document from the local database.
  ///
  /// This method removes the document identified by the given [uuid] from
  /// the local data source.
  ///
  /// [uuid] is the unique identifier of the document to be deleted.
  ///
  /// Throws an exception if the document cannot be found or if there is
  /// an error during the deletion process.
  Future<void> deleteDocument(String uuid);

  /// Updates the file path associated with a given UUID.
  ///
  /// This method updates the file path in the local database for the specified
  /// UUID. It is used to change the location of a file that is already tracked
  /// by the system.
  ///
  /// [uuid] The unique identifier for the file entry to be updated.
  /// [filePath] The new file path to be associated with the given UUID.
  ///
  /// Returns a [Future] that completes when the update operation is finished.
  Future<void> updateFilePath(String uuid, String filePath);

  /// Saves a chunk of the document by replacing an old node with a new node.
  ///
  /// This method updates the specified [document] by replacing the [oldNode]
  /// with the [newNode]. It is used to persist changes made to the document.
  ///
  /// [document] - The document that contains the nodes.
  /// [oldNode] - The node to be replaced.
  /// [newNode] - The node to replace the old node with.
  ///
  /// Returns a [Future] that completes when the operation is finished.
  Future<void> saveChunk(Document document, Node oldNode, Node newNode);
}

/// Implementation of the [DatabaseLocalDataSource] interface that provides
/// local data source functionalities for the database.
///
/// This class is responsible for handling all the local database operations
/// such as CRUD operations, data caching, and any other local data management
/// tasks required by the application.
class DatabaseLocalDataSourceImpl implements DatabaseLocalDataSource {
  DatabaseLocalDataSourceImpl._create(this.ref);

  /// A reference to the provider's state. This is used to interact with the
  /// state and perform various operations such as reading, updating, or
  /// listening to changes in the state.
  ///
  /// The `Ref` object is typically provided by the Riverpod package and
  /// is essential for managing state in a reactive way.
  Ref ref;
  late Database _databaseMetadata;
  late Database _databaseDocument;

  /// Creates an instance of [DatabaseLocalDataSourceImpl].
  ///
  /// This is an asynchronous method that initializes and returns a
  /// [DatabaseLocalDataSourceImpl] object.
  ///
  /// The [ref] parameter is a reference that is used during the creation
  /// process.
  ///
  /// Returns a [Future] that completes with the created
  /// [DatabaseLocalDataSourceImpl] instance.
  static Future<DatabaseLocalDataSourceImpl> create(Ref ref) async {
    final instance = DatabaseLocalDataSourceImpl._create(ref);
    await instance._initializeDatabases();
    return instance;
  }

  Future<void> _initializeDatabases() async {
    _databaseMetadata = await openDatabaseMetadata();
    _databaseDocument = await openDatabaseDocument();
  }

  @override
  Future<Database> openDatabaseMetadata() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDir.path}/metadata.db';
    return _databaseMetadata =
        await databaseFactoryIo.openDatabase(dbPath, mode: DatabaseMode.create);
  }

  @override
  Future<Database> openDatabaseDocument() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDir.path}/document.db';
    return _databaseDocument =
        await databaseFactoryIo.openDatabase(dbPath, mode: DatabaseMode.create);
  }

  @override
  Future<(String, bool)> getOrCreateUuidForFile(File file) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    final result = await store.find(
      _databaseMetadata,
      finder: Finder(filter: Filter.equals('filePath', file.path)),
    );
    if (result.isNotEmpty) {
      return (result.first.key, true);
    } else {
      final uuid = const Uuid().v4();
      final fileMetadata = await _getFileMetadata(file);
      await store.record(uuid).put(
            _databaseMetadata,
            fileMetadata.toMap(),
          );
      return (uuid, false);
    }
  }

  Future<FileMetadata> _getFileMetadata(File file) async {
    final stat = file.statSync();
    return FileMetadata(
      size: stat.size,
      path: file.path,
      name: file.path.split(Platform.pathSeparator).last,
      created: stat.changed.toIso8601String(),
      modified: stat.modified.toIso8601String(),
    );
  }

  @override
  Future<Document> fetchDocument(String uuid) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    final recordSnapshot = await store.record(uuid).get(_databaseDocument);

    if (recordSnapshot != null) {
      return Document.fromMap(recordSnapshot);
    } else {
      throw Exception('Document not found');
    }
  }

  @override
  Future<List<Document>> fetchAllDocuments() async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    final recordSnapshot = await store.find(_databaseDocument);
    return recordSnapshot.map((e) => Document.fromMap(e.value)).toList();
  }

  @override
  Future<FileMetadata> fetchFileMetadata(String uuid) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    final recordSnapshot = await store.record(uuid).get(_databaseMetadata);

    if (recordSnapshot != null) {
      return FileMetadata.fromMap(recordSnapshot);
    } else {
      throw Exception('File Metadata not found');
    }
  }

  @override
  Future<void> saveDocument(Document document) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    await store.record(document.uuid).put(_databaseDocument, document.toMap());
  }

  @override
  Future<void> deleteDocument(String uuid) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    await store.record(uuid).delete(_databaseDocument);
  }

  @override
  Future<void> updateFilePath(String uuid, String filePath) async {
    final store = StoreRef<String, Map<String, dynamic>>.main();
    final existingRecord = await store.record(uuid).get(_databaseMetadata);

    if (existingRecord != null) {
      existingRecord['filePath'] = filePath;
      await store.record(uuid).put(_databaseMetadata, existingRecord);
    }
  }

  @override
  Future<void> saveChunk(Document document, Node oldNode, Node newNode) async {
    // final store = StoreRef<String, Map<String, dynamic>>.main();
    // final existingRecord =
    //     await store.record(document.uuid).get(_databaseMetadata);
  }
}
