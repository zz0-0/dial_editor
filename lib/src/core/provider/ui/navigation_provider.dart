import 'package:dial_editor/src/feature/ui/presentation/view_model/navigation_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider for the navigation view model.
/// 
/// This provider is responsible for managing the state and logic related to 
/// navigation within the application. It ensures that the navigation state 
/// is accessible throughout the app and can be used to control navigation 
/// actions and state changes.
final navigationViewModelProvider =
    StateNotifierProvider<NavigationViewModel, void>((ref) {
  return NavigationViewModel();
});
