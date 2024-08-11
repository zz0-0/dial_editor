import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:dial_editor/src/core/provider/ui/search_branch_provider.dart';
import 'package:dial_editor/src/core/provider/ui/setting_branch_provider.dart';
import 'package:dial_editor/src/core/provider/ui/top_bar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationViewModel extends StateNotifier<void> {
  NavigationViewModel() : super(null);

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

  void openSearchSidePanel(WidgetRef ref) {
    ref.read(searchSidePanelProvider.notifier).update(
          (state) => !ref.read(searchSidePanelProvider),
        );
  }

  void openSettingSidePanel(WidgetRef ref) {
    ref.read(settingSidePanelProvider.notifier).update(
          (state) => !ref.read(settingSidePanelProvider),
        );
  }
}
