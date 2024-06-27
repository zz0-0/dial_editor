import 'package:dial_editor/src/feature/core/presentation/widget/sidepanel/side_panel_provider.dart';
import 'package:dial_editor/src/feature/core/presentation/widget/topbar/topbar.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/tab_part.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/screen/directory.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/screen/directory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DesktopEditor extends ConsumerStatefulWidget {
  const DesktopEditor({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DesktopEditorState();
}

class _DesktopEditorState extends ConsumerState<DesktopEditor> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20, child: Topbar()),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: ref.watch(sidePanelProvider)
                        ? const Directory()
                        : Container(),
                  ),
                  if (ref.watch(fileProvider) != null)
                    const Expanded(child: TabPart()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
