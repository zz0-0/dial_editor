import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpenedFilesNotifier extends StateNotifier<Set<String>> {
  OpenedFilesNotifier() : super({});

  void addFile(String filePath) {
    if (!state.contains(filePath)) {
      final current = Set<String>.from(state);
      current.add(filePath);
      state = current;
    }
  }

  void removeFile(String filePath) {
    if (state.contains(filePath)) {
      final current = Set<String>.from(state);
      current.remove(filePath);
      state = current;
    }
  }
}

final openedFilesProvider =
    StateNotifierProvider<OpenedFilesNotifier, Set<String>>((ref) {
  return OpenedFilesNotifier();
});
