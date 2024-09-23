import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:dial_editor/src/core/provider/ui/search_branch_provider.dart';
import 'package:dial_editor/src/core/provider/ui/setting_branch_provider.dart';
import 'package:dial_editor/src/core/provider/ui/top_bar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A ViewModel class that extends `StateNotifier<void>` to manage the state
/// for navigation-related functionality in the application.
///
/// This class is responsible for handling the navigation logic and updating
/// the state accordingly. It interacts with the UI layer to provide a seamless
/// navigation experience.
///
/// The `NavigationViewModel` does not hold any state itself, as indicated by
/// the `void` type parameter. Instead, it focuses on managing navigation
/// events and actions.
class NavigationViewModel extends StateNotifier<void> {
  /// A ViewModel for handling navigation-related logic in the application.
  ///
  /// This class extends a base ViewModel class and initializes it with a null
  /// value.
  /// It is responsible for managing the state and logic related to navigation
  /// within the app.
  NavigationViewModel() : super(null);

  /// Opens the file side panel in the UI.
  ///
  /// This method is responsible for displaying the file side panel
  /// which allows users to navigate and select files.
  ///
  /// [ref] is a reference to the widget, used to interact with the UI
  /// components.
  void openFileSidePanel(WidgetRef ref) {
    if (ref.read(openFolderProvider)) {
      ref.read(fileSidePanelProvider.notifier).update(
            (state) => !ref.read(fileSidePanelProvider),
          );
    } else {
      ref.read(fileEmptySidePanelProvider.notifier).update(
            (state) => !ref.read(fileEmptySidePanelProvider),
          );
    }
  }

  /// Opens the search side panel.
  ///
  /// This method is used to display the search side panel in the UI.
  ///
  /// [ref] is a reference to the widget that is calling this method.
  void openSearchSidePanel(WidgetRef ref) {
    ref.read(searchSidePanelProvider.notifier).update(
          (state) => !ref.read(searchSidePanelProvider),
        );
  }

  /// Opens the settings side panel.
  ///
  /// This method is used to display the settings side panel in the UI.
  ///
  /// [ref] is a reference to the widget that is calling this method.
  void openSettingSidePanel(WidgetRef ref) {
    ref.read(settingSidePanelProvider.notifier).update(
          (state) => !ref.read(settingSidePanelProvider),
        );
  }
}
