import 'package:dial_editor/src/feature/side_panel/file_directory/data/data_source/directory_local_data_source.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/data/repository_impl/directory_repository_impl.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/use_case/get_directory_list_use_case.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/presentation/view_model/directory_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A [FutureProvider] that provides access to the directory repository.
///
/// This provider is responsible for asynchronously fetching and managing
/// the directory repository, which can be used to interact with the file
/// system or other directory-related operations.
///
/// The provider is created using the ref parameter, which allows it to
/// access other providers and services within the application.
final directoryRepositoryProvider = FutureProvider((ref) {
  final directoryLocalDataSource = DirectoryLocalDataSourceImpl(ref);
  return DirectoryRepositoryImpl(
    localDataSource: directoryLocalDataSource,
  );
});

/// A [FutureProvider] that asynchronously fetches a list of directories.
///
/// This provider uses the `getDirectoryListUseCase` to retrieve the directory
/// list and makes it available to the rest of the application through the
/// provider framework.
///
/// Usage:
/// ```dart
/// final directoryList = ref.watch(getDirectoryListUseCaseProvider);
/// ```
///
/// Returns a [Future] that completes with the list of directories.
final getDirectoryListUseCaseProvider = FutureProvider((ref) async {
  final repository = await ref.watch(directoryRepositoryProvider.future);
  return GetDirectoryListUseCase(repository);
});

/// A provider for the DirectoryViewModel, which manages the state and logic
/// related to the directory side panel in the application.
///
/// This provider is used to access and manipulate the directory view model
/// throughout the application, ensuring a consistent state and behavior.
///
/// Usage:
/// ```dart
/// final directoryViewModel = context.read(directoryViewModelProvider);
/// ```
///
/// The provider can be used to listen to changes in the directory view model
/// and rebuild widgets accordingly.
final directoryViewModelProvider =
    StateNotifierProvider<DirectoryViewModel, List<DirectoryNode>>(
  (ref) {
    return DirectoryViewModel(ref);
  },
);

/// A provider that asynchronously opens a file.
///
/// This provider is responsible for handling the logic to open a file
/// and can be used throughout the application to access the opened file.
///
/// Usage:
/// ```dart
/// final file = ref.watch(openFileProvider);
/// ```
///
/// Returns:
///   A Future that completes with the opened file.
final openFileProvider = Provider((ref) async {
  final repository = await ref.watch(directoryRepositoryProvider.future);
  return repository.getFileSystemEntity();
});

/// A provider that handles the creation of a new file.
///
/// This provider is asynchronous and can be used to trigger the creation
/// of a new file within the application. It utilizes the Riverpod package
/// to manage state and dependencies.
///
/// Usage:
/// ```dart
/// final newFile = await context.read(createNewFileProvider);
/// ```
///
/// Returns:
/// - A future that completes when the new file is created.
final createNewFileProvider = Provider((ref) async {
  final repository = await ref.watch(directoryRepositoryProvider.future);
  return repository.createNewFile();
});

/// A provider that supplies the default indentation value for the side panel
/// directory.
///
/// This provider returns an integer value representing the number of spaces
/// used for indentation. The default value is set to 40.
///
/// Usage:
/// ```dart
/// final indentation = ref.watch(indentationProvider);
/// ```
///
/// This can be used to control the indentation level in the side panel
/// directory
/// of the application.
final indentationProvider = Provider((ref) => 40);

/// A provider that supplies the size of icons.
///
/// This provider returns an integer value representing the size of icons,
/// which is set to 40 by default.
///
/// Usage:
/// ```dart
/// final iconSize = ref.watch(iconSizeProvider);
/// ```
final iconSizeProvider = Provider((ref) => 40);

/// A provider that manages the expanded state of directory nodes in the
/// side panel.
/// This provider is used to keep track of which directory nodes are expanded
/// or collapsed,
/// allowing the UI to reflect the current state of the directory structure.
final directoryNodeExpandedProvider =
    StateProvider.family<bool, Key>((ref, arg) => false);
