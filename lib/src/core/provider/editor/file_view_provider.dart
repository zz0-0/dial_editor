import 'package:dial_editor/src/feature/editor/data/data_source/file_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/document_repository_impl.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/node_repository_impl.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/convert_document_line_use_case.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_document_children_use_case.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/save_document_use_case.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/update_node_style_use_case.dart';
import 'package:dial_editor/src/feature/editor/presentation/helper/render_adapter.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/node_list_state_notifier.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/node_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  return DocumentRepositoryImpl(
    fileLocalDataSource: FileLocalDataSourceImpl(ref),
  );
});

final getDocumentChildrenUseCaseProvider =
    Provider<GetDocumentChildrenUseCase>((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return GetDocumentChildrenUseCase(repository);
});

final saveDocumentUseCaseProvider = Provider<SaveDocumentUseCase>((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return SaveDocumentUseCase(repository);
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
