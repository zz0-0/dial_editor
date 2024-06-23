import 'package:dial_editor/src/feature/editor/presentation/widget/tab_part.dart';
import 'package:dial_editor/src/feature/core/presentation/widget/sidepanel/directory/file_directory.dart';
import 'package:dial_editor/src/feature/core/presentation/widget/sidepanel/directory/side_panel_provider.dart';
import 'package:dial_editor/src/feature/core/presentation/widget/topbar/topbar.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/provider/directory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Editor extends ConsumerStatefulWidget {
  const Editor({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditorState();
}

class _EditorState extends ConsumerState<Editor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20, child: Topbar()),
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: ref.watch(sidePanelProvider)
                    ? const FileDirectory()
                    : Container(),
              ),
              if (ref.watch(fileProvider) != null)
                const Expanded(child: TabPart()),
            ],
          ),
        ),
      ],
    );
  }
}
