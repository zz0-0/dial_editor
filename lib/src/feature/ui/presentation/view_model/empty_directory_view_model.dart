import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:dial_editor/src/core/provider/ui/top_bar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A view model that extends `StateNotifier<void>` to manage the state for
/// an empty directory view.
///
/// This class is responsible for handling the logic and state management
/// for views that represent an empty directory in the application.
///
/// It does not hold any state itself, as indicated by the `void` type
/// parameter.
class EmptyDirectoryViewModel extends StateNotifier<void> {
  /// A ViewModel class representing an empty directory state.
  ///
  /// This class extends a base ViewModel class and initializes it with a
  /// null value.
  EmptyDirectoryViewModel() : super(null);

  /// Opens a folder using the provided [WidgetRef].
  ///
  /// This method is responsible for handling the logic to open a folder
  /// within the application. The [WidgetRef] parameter is used to access
  /// and manipulate the state of the widget tree.
  ///
  /// [ref] - A reference to the widget that will be used to open the folder.
  void openFolder(WidgetRef ref) {
    ref.read(fileEmptySidePanelProvider.notifier).update((state) => false);
    ref.read(openFolderProvider.notifier).update((state) => true);
    ref.read(fileSidePanelProvider.notifier).update((state) => true);
  }
}
