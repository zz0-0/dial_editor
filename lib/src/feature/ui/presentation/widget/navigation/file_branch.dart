import 'package:dial_editor/main_provider.dart';
import 'package:dial_editor/src/feature/ui/presentation/provider/directory_provider.dart';
import 'package:dial_editor/src/feature/ui/presentation/provider/side_panel_provider.dart';
import 'package:dial_editor/src/feature/ui/presentation/provider/top_bar_provider.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/main_area/editor/tab_part.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/sidepanel/file_directory/directory.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/sidepanel/file_directory/empty_directory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileBranch extends ConsumerStatefulWidget {
  const FileBranch({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FileBranchState();
}

class _FileBranchState extends ConsumerState<FileBranch> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = ref.read(isDesktopProvider);
    if (ref.watch(openFolderProvider)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (ref.watch(fileSidePanelProvider)) const Directory(),
          if (ref.watch(fileSidePanelProvider))
            const VerticalDivider(thickness: 1, width: 1),
          if (ref.watch(fileProvider) != null) const Expanded(child: TabPart()),
        ],
      );
    } else {
      if (isDesktop) {
        return Row(
          children: [
            if (ref.watch(fileEmptySidePanelProvider)) const EmptyDirectory(),
            if (ref.watch(fileEmptySidePanelProvider))
              const VerticalDivider(thickness: 1, width: 1),
            const Expanded(child: Center(child: Text("Dial Editor"))),
          ],
        );
      } else {
        return Row(
          children: [
            if (ref.watch(fileProvider) != null)
              const Expanded(child: TabPart()),
          ],
        );
      }
    }
  }
}
