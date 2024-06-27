import 'package:dial_editor/src/feature/editor/presentation/widget/tab_part.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/screen/directory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileEditor extends ConsumerStatefulWidget {
  const MobileEditor({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MobileEditorState();
}

class _MobileEditorState extends ConsumerState<MobileEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // const SizedBox(height: 20, child: Topbar()),
          Expanded(
            child: Row(
              children: [
                // SizedBox(
                //   width: 200,
                //   child: ref.watch(sidePanelProvider)
                //       ? const Directory()
                //       : Container(),
                // ),
                if (ref.watch(fileProvider) != null)
                  const Expanded(child: TabPart()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
