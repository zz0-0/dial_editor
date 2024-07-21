import 'dart:io';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/file_view_provider.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/widget/directory_provider.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileEditor extends ConsumerStatefulWidget {
  final MaterialApp child;

  const MobileEditor({super.key, required this.child});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MobileEditorState();
}

class _MobileEditorState extends ConsumerState<MobileEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Open File'),
              onTap: () async {
                final XFile? xFile = await openFile();
                final File file = File(xFile!.path);
                ref.read(fileProvider.notifier).update((state) => file);
                ref.read(openedFilesProvider.notifier).addFile(file.path);
              },
            ),
          ],
        ),
      ),
      body: widget.child,
    );
  }
}
