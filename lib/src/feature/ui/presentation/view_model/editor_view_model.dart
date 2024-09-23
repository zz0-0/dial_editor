import 'package:dial_editor/src/core/provider/ui/editor_provder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A notifier that manages a set of opened files.
///
/// This class extends `StateNotifier` and is responsible for keeping track
/// of the currently opened files in the editor. The state is represented
/// as a `Set<String>`, where each string is a file path.
class OpenedFilesNotifier extends StateNotifier<Set<String>> {
  /// A notifier class that manages the state of opened files.
  ///
  /// This class extends a base notifier and initializes with an empty map.
  ///
  /// The [ref] parameter is a reference that is passed to the constructor.
  OpenedFilesNotifier(this.ref) : super({});

  /// A reference to the provider's state. This is used to interact with and
  /// read the state of providers within the application.
  ///
  /// The `Ref` object allows access to the state of providers, enabling
  /// the ViewModel to read and manipulate the state as needed.
  Ref ref;

  /// Adds a file to the editor using the provided file path.
  ///
  /// This method takes a [filePath] as a parameter and performs the necessary
  /// operations to include the file in the editor's context.
  ///
  /// - Parameter [filePath]: The path of the file to be added.
  void addFile(String filePath) {
    if (!state.contains(filePath)) {
      final current = Set<String>.from(state)..add(filePath);
      state = current;
    } else {
      ref.read(selectedFileProvider.notifier).state = filePath;
    }
  }

  /// Removes the file at the specified file path.
  ///
  /// This method deletes the file located at the given [filePath].
  ///
  /// [filePath] - The path of the file to be removed.
  void removeFile(String filePath) {
    if (state.contains(filePath)) {
      final current = Set<String>.from(state)..remove(filePath);
      state = current;
      if (ref.read(selectedFileProvider.notifier).state == filePath) {
        ref.read(selectedFileProvider.notifier).state =
            current.isNotEmpty ? current.first : null;
      }
    }
  }
}
