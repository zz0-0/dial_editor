import 'package:dial_editor/src/feature/ui/presentation/view_model/navigation_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationViewModelProvider =
    StateNotifierProvider<NavigationViewModel, void>((ref) {
  return NavigationViewModel();
});
