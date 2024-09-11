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
import 'package:dial_editor/src/feature/editor/domain/use_case/get_file_metadata_use_case.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/save_document_use_case.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/update_node_style_use_case.dart';
import 'package:dial_editor/src/feature/editor/presentation/helper/render_adapter.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/document_list_state_notifier.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/file_metadata_state_notifer.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/node_list_state_notifier.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/node_state_notifier.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/tree_node_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseLocalDataSourceProvider =
    FutureProvider<DatabaseLocalDataSource>((ref) async {
  return await DatabaseLocalDataSourceImpl.create(ref);
});

final fileLocalDataSourceProvider = Provider<FileLocalDataSource>((ref) {
  return FileLocalDataSourceImpl(ref);
});

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

final getDocumentChildrenUseCaseProvider =
    FutureProvider<GetDocumentChildrenUseCase>((ref) async {
  final repository = await ref.watch(documentRepositoryProvider.future);
  return GetDocumentChildrenUseCase(repository);
});

final saveDocumentToFileUseCaseProvider =
    FutureProvider<SaveDocumentToFileUseCase>((ref) async {
  final repository = await ref.watch(documentRepositoryProvider.future);
  return SaveDocumentToFileUseCase(repository);
});

final nodeRepositoryProvider = Provider<NodeRepository>((ref) {
  return NodeRepositoryImpl();
});

final convertStringToLineUseCaseProvider =
    Provider<ConvertStringToLineUseCase>((ref) {
  final repository = ref.watch(nodeRepositoryProvider);
  return ConvertStringToLineUseCase(repository);
});

final renderAdapterProvider = Provider<RenderAdapter>((ref) {
  return RenderAdapter(ref);
});

final updateNodeStyleUseCaseProvider = Provider<UpdateNodeStyleUseCase>((ref) {
  return UpdateNodeStyleUseCase();
});

final nodeListStateNotifierProvider =
    StateNotifierProvider<NodeListStateNotifier, List<Node>>((ref) {
  return NodeListStateNotifier(ref);
});

final nodeStateProvider =
    StateNotifierProvider.family<NodeStateNotifier, List<Inline?>, GlobalKey>(
        (ref, key) {
  return NodeStateNotifier(ref, key);
});

final scrollController1Provider = Provider((ref) => ScrollController());
final scrollController2Provider = Provider((ref) => ScrollController());
final scrollController3Provider = Provider((ref) => ScrollController());

final toggleNodeExpansionKeyProvider = StateProvider<GlobalKey?>((ref) => null);

final getAllDocumentElementUseCaseProvider =
    FutureProvider<GetAllDocumentElementUseCase>((ref) async {
  final repository = await ref.watch(documentRepositoryProvider.future);
  return GetAllDocumentElementUseCase(repository);
});

final documentListStateNotifierProvider =
    StateNotifierProvider<DocumentListStateNotifier, List<Document>>((ref) {
  return DocumentListStateNotifier(ref);
});

final nodeIncomingConnectionProvider =
    Provider.family<List<Connection>, GlobalKey>((ref, key) {
  if (ref.watch(nodeStateProvider(key)).isEmpty) return [];
  return ref
      .watch(nodeStateProvider(key))[0]!
      .attribute
      .connections
      .values
      .toList();
});

final fileMetaRepositoryProvider = FutureProvider((ref) async {
  final databaseLocalDataSource =
      await ref.watch(databaseLocalDataSourceProvider.future);
  return FileMetadataRepositoryImpl(
    databaseLocalDataSource: databaseLocalDataSource,
  );
});

final getFileMetadataUseCaseProvider =
    FutureProvider<GetFileMetadataUseCase>((ref) async {
  final repository = await ref.watch(fileMetaRepositoryProvider.future);
  return GetFileMetadataUseCase(repository);
});

final fileMetadataStateNotiferProvider = StateNotifierProvider.family<
    FileMetadataStateNotifer, List<FileMetadata>, String>((ref, key) {
  return FileMetadataStateNotifer(ref, key);
});

final checkboxProvider = StateProvider.family<bool?, String>((ref, key) {
  return false;
});

final treeNodeProvider =
    StateNotifierProvider<TreeNodeStateNotifier, atv.TreeNode>((ref) {
  return TreeNodeStateNotifier(ref);
});
