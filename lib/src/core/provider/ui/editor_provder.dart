import 'package:dial_editor/src/feature/ui/presentation/view_model/editor_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A [StateProvider] that holds the currently selected file path as a [String].
/// 
/// This provider is initialized with a `null` value, indicating that no file
/// is selected by default. It can be used to track the file path of the
/// currently selected file in the UI.
/// 
/// Example usage:
/// 
/// ```dart
/// final selectedFile = ref.watch(selectedFileProvider).state;
/// if (selectedFile != null) {
///   // Do something with the selected file path
/// }
/// ```
final selectedFileProvider = StateProvider<String?>((ref) => null);

/// A provider that manages the state of opened files in the editor.
/// 
/// This provider is responsible for keeping track of the files that are 
/// currently opened in the editor, allowing for operations such as 
/// adding, removing, and switching between files.
/// 
/// Usage:
/// 
/// ```dart
/// final openedFiles = context.read(openedFilesProvider);
/// ```
/// 
/// This can be used to access the list of opened files and perform 
/// various operations on them.
final openedFilesProvider =
    StateNotifierProvider<OpenedFilesNotifier, Set<String>>((ref) {
  return OpenedFilesNotifier(ref);
});
