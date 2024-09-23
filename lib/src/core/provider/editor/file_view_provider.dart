import 'package:animated_tree_view/animated_tree_view.dart' as atv;
import 'package:dial_editor/src/feature/editor/data/data_source/database_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/data_source/file_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/document_repository_impl.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/file_metadata_repository_impl.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/node_repository_impl.dart';
import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/convert_document_line_use_case.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_all_document_element_use_case.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_document_children_use_case.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_document_use_case.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_file_metadata_use_case.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/save_document_use_case.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/update_node_style_use_case.dart';
import 'package:dial_editor/src/feature/editor/presentation/helper/render_adapter.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/current_document_state_notifier.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/document_list_state_notifier.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/file_metadata_state_notifer.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/node_incoming_connection_state_notifier.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/node_list_state_notifier.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/node_outgoing_connection_state_notifier.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/node_state_notifier.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/tree_node_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider for accessing the local data source of the database.
///
/// This provider is responsible for managing and providing access to the
/// local data source, which includes operations such as reading from and
/// writing to the local database.
///
/// Usage:
/// ```dart
/// final localDataSource = context.read(databaseLocalDataSourceProvider);
/// ```
///
/// Ensure that the provider is properly initialized and disposed of
/// according to the application's lifecycle.
final databaseLocalDataSourceProvider =
    FutureProvider<DatabaseLocalDataSource>((ref) async {
  return DatabaseLocalDataSourceImpl.create(ref);
});

/// A provider for the `FileLocalDataSource` instance.
///
/// This provider is responsible for creating and managing the lifecycle of
/// the `FileLocalDataSource` object, which handles local file operations
/// within the application.
///
/// The provider uses the `ref` parameter to access other providers and
/// resources if needed.
///
/// Usage:
/// ```dart
/// final fileLocalDataSource = ref.watch(fileLocalDataSourceProvider);
/// ```
final fileLocalDataSourceProvider = Provider<FileLocalDataSource>((ref) {
  return FileLocalDataSourceImpl(ref);
});

/// A provider for the document repository.
///
/// This provider is responsible for managing and supplying the document
/// repository instance, which is used to perform operations related to
/// document storage and retrieval.
///
/// Usage:
/// ```dart
/// final documentRepository = context.read(documentRepositoryProvider);
/// ```
///
/// This allows you to access the document repository from the provider
/// within your application.
final documentRepositoryProvider =
    FutureProvider<DocumentRepository>((ref) async {
  final databaseLocalDataSource =
      await ref.watch(databaseLocalDataSourceProvider.future);
  final fileLocalDataSource = ref.watch(fileLocalDataSourceProvider);

  return DocumentRepositoryImpl(
    fileLocalDataSource: fileLocalDataSource,
    databaseLocalDataSource: databaseLocalDataSource,
  );
});

/// A provider for the use case that retrieves the children of a document.
///
/// This provider is responsible for managing the state and dependencies
/// required to fetch and handle the children of a document within the editor.
/// It utilizes the `getDocumentChildrenUseCase` to perform the actual
/// retrieval of the document's children.
final getDocumentChildrenUseCaseProvider =
    FutureProvider<GetDocumentChildrenUseCase>((ref) async {
  final repository = await ref.watch(documentRepositoryProvider.future);
  return GetDocumentChildrenUseCase(repository);
});

/// A provider for the use case that handles saving a document to a file.
///
/// This provider is responsible for managing the logic required to save
/// the current document to a specified file location. It ensures that
/// the document's content is correctly written to the file system.
///
/// Usage:
/// ```dart
/// final saveDocument = context.read(saveDocumentToFileUseCaseProvider);
/// saveDocument(document);
/// ```
///
/// Returns:
/// - An instance of the use case that can be called to save the document.
final saveDocumentToFileUseCaseProvider =
    FutureProvider<SaveDocumentToFileUseCase>((ref) async {
  final repository = await ref.watch(documentRepositoryProvider.future);
  return SaveDocumentToFileUseCase(repository);
});

/// A provider for the `NodeRepository` instance.
///
/// This provider is responsible for creating and managing the lifecycle of
/// the `NodeRepository` object, which is used to interact with and manage
/// nodes within the application.
///
/// The provider takes a `ref` parameter, which is a reference to the
/// provider's context, allowing it to access other providers and resources
/// as needed.
///
/// Usage:
/// ```dart
/// final nodeRepository = ref.watch(nodeRepositoryProvider);
/// ```
///
/// Returns:
/// - An instance of `NodeRepository`.
final nodeRepositoryProvider = Provider<NodeRepository>((ref) {
  return NodeRepositoryImpl();
});

/// A provider for the use case that converts a string to a line.
/// This provider is responsible for managing the state and dependencies
/// required to perform the conversion operation.
final convertStringToLineUseCaseProvider =
    Provider<ConvertStringToLineUseCase>((ref) {
  final repository = ref.watch(nodeRepositoryProvider);
  return ConvertStringToLineUseCase(repository);
});

/// A provider for the `RenderAdapter` instance.
///
/// This provider is responsible for creating and managing the lifecycle of
/// the `RenderAdapter` object. It uses the `Provider` class from the
/// Riverpod package to handle dependency injection and state management.
///
/// The `RenderAdapter` is typically used to render and manage the view
/// of the editor.
///
/// Usage:
/// ```dart
/// final renderAdapter = ref.watch(renderAdapterProvider);
/// ```
///
/// Returns:
/// - An instance of `RenderAdapter`.
final renderAdapterProvider = Provider<RenderAdapter>((ref) {
  return RenderAdapter(ref);
});

/// A provider for the `UpdateNodeStyleUseCase` instance.
///
/// This provider is responsible for creating and managing the lifecycle
/// of the `UpdateNodeStyleUseCase` which is used to update the style
/// of a node in the editor.
///
/// The provider takes a reference (`ref`) as a parameter which can be
/// used to access other providers or resources.
///
/// Usage:
/// ```dart
/// final updateNodeStyleUseCase = ref.watch(updateNodeStyleUseCaseProvider);
/// ```
final updateNodeStyleUseCaseProvider = Provider<UpdateNodeStyleUseCase>((ref) {
  return UpdateNodeStyleUseCase();
});

/// A provider for managing the state of the node list in the editor.
///
/// This provider is responsible for notifying listeners about changes
/// to the node list state, allowing the UI to react accordingly.
///
/// Usage:
/// ```dart
/// final nodeListState = context.read(nodeListStateNotifierProvider);
/// ```
///
/// Listeners can subscribe to this provider to get updates whenever
/// the node list state changes.
final nodeListStateNotifierProvider =
    StateNotifierProvider<NodeListStateNotifier, List<Node>>((ref) {
  return NodeListStateNotifier(ref);
});

/// A provider that manages the state of nodes within the editor.
/// This provider is responsible for handling the state changes and
/// providing the necessary data to the UI components that display
/// the nodes in the file view.
final nodeStateProvider =
    StateNotifierProvider.family<NodeStateNotifier, List<Inline?>, GlobalKey>(
        (ref, key) {
  return NodeStateNotifier(ref, key);
});

/// A provider that creates and manages a [ScrollController] instance.
///
/// This provider can be used to control the scrolling behavior of a widget
/// that requires a [ScrollController]. It ensures that the same instance
/// of [ScrollController] is used across the widget tree, allowing for
/// consistent and synchronized scrolling.
///
/// Usage:
/// ```dart
/// final scrollController = ref.watch(scrollController1Provider);
/// ```
///
/// Returns:
///   A [ScrollController] instance.
final scrollController1Provider = Provider((ref) => ScrollController());

/// A provider that creates and manages a [ScrollController] instance.
///
/// This provider can be used to control the scrolling behavior of a widget
/// that requires a [ScrollController]. It ensures that the same instance
/// of [ScrollController] is used across the widget tree, allowing for
/// consistent and synchronized scrolling.
///
/// Usage:
/// ```dart
/// final scrollController = ref.watch(scrollController1Provider);
/// ```
///
/// Returns:
///   A [ScrollController] instance.
final scrollController2Provider = Provider((ref) => ScrollController());

/// A provider that creates and manages a [ScrollController] instance.
///
/// This provider can be used to control the scrolling behavior of a widget
/// that requires a [ScrollController]. It ensures that the same instance
/// of [ScrollController] is used across the widget tree, allowing for
/// consistent and synchronized scrolling.
///
/// Usage:
/// ```dart
/// final scrollController = ref.watch(scrollController1Provider);
/// ```
///
/// Returns:
///   A [ScrollController] instance.
final scrollController3Provider = Provider((ref) => ScrollController());

/// A state provider that holds a [GlobalKey] which can be used to toggle the
/// expansion state of a node in the editor. Initially, the key is set to null.
final toggleNodeExpansionKeyProvider = StateProvider<GlobalKey?>((ref) => null);

/// A provider for the use case that retrieves all document elements.
///
/// This provider is responsible for managing the state and dependencies
/// required to fetch and handle all elements within a document. It can be
/// used to access the use case throughout the application, ensuring a
/// consistent and centralized approach to document element retrieval.
final getAllDocumentElementUseCaseProvider =
    FutureProvider<GetAllDocumentElementUseCase>((ref) async {
  final repository = await ref.watch(documentRepositoryProvider.future);

  return GetAllDocumentElementUseCase(repository);
});

/// A provider for the `GetDocumentUseCase`.
///
/// This provider is responsible for managing the state and
/// dependencies required to fetch and handle documents within
/// the application. It utilizes the `GetDocumentUseCase` to
/// perform the necessary operations.
///
/// Usage:
/// ```dart
/// final document = context.read(getDocumentUseCaseProvider);
/// ```
///
/// Ensure that the provider is properly initialized and
/// available in the widget tree before attempting to access it.
final getDocumentUseCaseProvider =
    FutureProvider<GetDocumentUseCase>((ref) async {
  final repository = await ref.watch(documentRepositoryProvider.future);
  return GetDocumentUseCase(repository);
});

/// A provider that notifies listeners about the current state of the document.
///
/// This provider can be used to access and listen to changes in the document's
/// state within the application. It is particularly useful for managing and
/// reacting to updates in the document's content or metadata.
final currentDocumentStateNotifierProvider =
    StateNotifierProvider<CurrentDocumentStateNotifier, Document?>((ref) {
  return CurrentDocumentStateNotifier(ref);
});

/// A provider that manages the state of the document list.
///
/// This provider is responsible for notifying listeners about changes
/// to the document list state, allowing the UI to react accordingly.
///
/// Usage:
/// ```dart
/// final documentListState = context.read(documentListStateNotifierProvider);
/// ```
///
/// Listeners can subscribe to this provider to get updates whenever
/// the document list state changes.
final documentListStateNotifierProvider =
    StateNotifierProvider<DocumentListStateNotifier, List<Document>>((ref) {
  return DocumentListStateNotifier(ref);
});

// final nodeIncomingConnectionProvider =
//     StateProvider.family<Set<Connection>, GlobalKey>((ref, key) {
//   if (ref.watch(nodeStateProvider(key)).isEmpty) return {};
//   return ref
//       .watch(nodeStateProvider(key))[0]!
//       .attribute
//       .connections
//       .values
//       .toSet();
// });

// final nodeOutgoingConnectionProvider =
//     StateProvider.family<Set<Connection>, GlobalKey>((ref, key) {
//   if (ref.watch(nodeStateProvider(key)).isEmpty) return {};
//   return ref
//       .watch(nodeStateProvider(key))[0]!
//       .attribute
//       .connections
//       .values
//       .toSet();
// });

/// A provider that manages the state of incoming connections for a specific
/// node.
///
/// This provider uses a family modifier to allow for parameterized state
/// management,
/// enabling the handling of multiple nodes with distinct states.
///
/// The `StateNotifierProvider.family` is used to create a provider that can
/// manage
/// state based on an external parameter, which in this case is likely the node
/// identifier.
///
/// Example usage:
/// ```dart
/// final connectionState =
/// context.read(nodeIncomingConnectionProvider(nodeId));
/// ```
///
/// This allows for dynamic state management based on the node ID provided.
final nodeIncomingConnectionProvider = StateNotifierProvider.family<
    NodeIncomingConnectionStateNotifier,
    Set<Connection>,
    GlobalKey>((ref, key) {
  return NodeIncomingConnectionStateNotifier(ref, key);
});

/// A provider that manages the state of outgoing connections for a specific
/// node.
///
/// This provider uses a family modifier to allow for parameterized state
/// management,
/// enabling the creation of multiple instances of the provider with different
/// parameters.
///
/// The provider is a `StateNotifierProvider` which means it uses a
/// `StateNotifier` to
/// manage its state. This allows for more complex state logic and side effects.
///
/// Example usage:
/// ```dart
/// final connectionProvider =
/// context.read(nodeOutgoingConnectionProvider(nodeId));
/// ```
///
/// - `nodeId`: The unique identifier for the node whose outgoing connections
/// are being managed.
final nodeOutgoingConnectionProvider = StateNotifierProvider.family<
    NodeOutgoingConnectionStateNotifier,
    Set<Connection>,
    GlobalKey>((ref, key) {
  return NodeOutgoingConnectionStateNotifier(ref, key);
});

/// A [FutureProvider] that asynchronously provides metadata for a file.
///
/// This provider fetches the file metadata using the given reference.
/// It is intended to be used within the context of a file editor to manage
/// and display file-related information.
///
/// Usage:
/// ```dart
/// final fileMeta = ref.watch(fileMetaRepositoryProvider);
/// ```
///
/// Returns a [Future] that completes with the file metadata.
final fileMetaRepositoryProvider = FutureProvider((ref) async {
  final databaseLocalDataSource =
      await ref.watch(databaseLocalDataSourceProvider.future);
  return FileMetadataRepositoryImpl(
    databaseLocalDataSource: databaseLocalDataSource,
  );
});

/// A provider for the use case that retrieves file metadata.
///
/// This provider is responsible for managing the state and dependencies
/// required to fetch and handle metadata of files within the application.
/// It leverages the `getFileMetadataUseCase` to perform the actual
/// retrieval of metadata.
///
/// Usage:
/// ```dart
/// final metadata = context.read(getFileMetadataUseCaseProvider);
/// ```
///
/// Returns:
/// - An instance of the use case that can be used to get file metadata.
final getFileMetadataUseCaseProvider =
    FutureProvider<GetFileMetadataUseCase>((ref) async {
  final repository = await ref.watch(fileMetaRepositoryProvider.future);
  return GetFileMetadataUseCase(repository);
});

/// A provider that creates a [StateNotifier] for managing the state of file 
/// metadata.
///
/// This provider uses the `family` modifier, which allows it to take a 
/// parameter
/// and create a unique instance of the [StateNotifier] for each different 
/// parameter.
///
/// Example usage:
///
/// ```dart
/// final fileMetadataState = 
/// context.read(fileMetadataStateNotiferProvider(fileId));
/// ```
///
/// The parameter `fileId` can be used to fetch or update the metadata for a 
/// specific file.
final fileMetadataStateNotiferProvider = StateNotifierProvider.family<
    FileMetadataStateNotifer, List<FileMetadata>, String>((ref, key) {
  return FileMetadataStateNotifer(ref, key);
});

/// A state provider that manages the state of a checkbox.
///
/// This provider uses a family modifier to allow for multiple instances
/// of the state, each identified by a unique [key].
///
/// The state is of type [bool?], which means it can be true, false, or null.
///
/// - [ref]: A reference to the provider's context.
/// - [key]: A unique identifier for each instance of the state.
final checkboxProvider = StateProvider.family<bool?, String>((ref, key) {
  return false;
});

/// A provider that manages the state of tree nodes in the editor.
///
/// This provider uses a `StateNotifier` to handle the state of tree nodes,
/// allowing for reactive updates and state management within the editor.
///
/// The `TreeNodeStateNotifier` is responsible for defining the state and
/// the logic to manipulate the state of the tree nodes.
///
/// Usage:
///
/// ```dart
/// final treeNodeState = context.read(treeNodeProvider);
/// ```
///
/// The `treeNodeProvider` can be used to read and watch the state of tree nodes
/// in the editor, enabling dynamic and responsive UI updates based on the state
/// changes.
final treeNodeProvider = StateNotifierProvider<TreeNodeStateNotifier,
    AsyncValue<atv.TreeNode<dynamic>>>((ref) {
  return TreeNodeStateNotifier(ref);
});

/// A [StateProvider] that holds the current [Document].
///
/// This provider is used to manage the state of the currently
/// selected or active document within the application. It is
/// initialized with a `null` value, indicating that no document
/// is currently selected.
///
/// Usage:
///
/// ```dart
/// final document = ref.watch(currentDocumentProvider).state;
/// ```
///
/// The state can be updated by using:
///
/// ```dart
/// ref.read(currentDocumentProvider).state = newDocument;
/// ```
///
/// where `newDocument` is an instance of [Document].
final currentDocumentProvider = StateProvider<Document?>((ref) => null);
