import 'package:dial_editor/src/core/provider/ui/editor_provder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
