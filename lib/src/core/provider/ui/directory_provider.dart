import 'package:dial_editor/src/feature/ui/presentation/view_model/empty_directory_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emptyDirectoryViewModelProvider =
    StateNotifierProvider<EmptyDirectoryViewModel, void>((ref) {
  return EmptyDirectoryViewModel();
});
