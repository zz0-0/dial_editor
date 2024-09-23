import 'package:dial_editor/src/feature/ui/presentation/view_model/empty_directory_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider for the view model of an empty directory.
/// 
/// This provider is used to manage the state and behavior of the UI 
/// when the directory being viewed is empty. It helps in maintaining 
/// a clean separation between the UI and the business logic.
final emptyDirectoryViewModelProvider =
    StateNotifierProvider<EmptyDirectoryViewModel, void>((ref) {
  return EmptyDirectoryViewModel();
});
