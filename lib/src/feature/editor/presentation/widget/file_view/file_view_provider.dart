import 'package:flutter_riverpod/flutter_riverpod.dart';

final openedFilesProvider =
    StateNotifierProvider<OpenedFilesNotifier, Set<String>>((ref) {
  return OpenedFilesNotifier(ref);
});
final selectedFileProvider = StateProvider<String?>((ref) => null);

class OpenedFilesNotifier extends StateNotifier<Set<String>> {
  Ref ref;

  OpenedFilesNotifier(this.ref) : super({});

  void addFile(String filePath) {
    if (!state.contains(filePath)) {
      final current = Set<String>.from(state);
      current.add(filePath);
      state = current;
    } else {
      ref.read(selectedFileProvider.notifier).state = filePath;
    }
  }

  void removeFile(String filePath) {
    if (state.contains(filePath)) {
      final current = Set<String>.from(state);
      current.remove(filePath);
      state = current;
      if (ref.read(selectedFileProvider.notifier).state == filePath) {
        ref.read(selectedFileProvider.notifier).state =
            current.isNotEmpty ? current.first : null;
      }
    }
  }
}
