import 'package:dial_editor/src/feature/core/presentation/widget/sidepanel/side_panel_provider.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_tab_part.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/screen/directory.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/screen/directory_provider.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/screen/empty_directory.dart';
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
    if (ref.watch(sidePanelProvider) == false) {
      return Row(
        children: [
          if (ref.watch(emptySidePanelProvider)) const EmptyDirectory(),
          if (ref.watch(emptySidePanelProvider))
            const VerticalDivider(thickness: 1, width: 1),
          const Expanded(child: Center(child: Text("Dial Editor"))),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Directory(),
          const VerticalDivider(thickness: 1, width: 1),
          if (ref.watch(fileProvider) != null)
            const Expanded(child: FileTabPart()),
        ],
      );
    }
  }
}