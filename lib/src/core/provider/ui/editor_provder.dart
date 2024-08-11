import 'package:dial_editor/src/feature/ui/presentation/view_model/editor_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedFileProvider = StateProvider<String?>((ref) => null);

final openedFilesProvider =
    StateNotifierProvider<OpenedFilesNotifier, Set<String>>((ref) {
  return OpenedFilesNotifier(ref);
});
