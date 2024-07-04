import 'dart:io';

import 'package:dial_editor/src/feature/editor/presentation/widget/edit_part.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/edit_part_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileTabPart extends ConsumerStatefulWidget {
  const FileTabPart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FileTabPartState();
}

class _FileTabPartState extends ConsumerState<FileTabPart>
    with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 0, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final openedFiles = ref.watch(openedFilesProvider);
    final String? selectedFile = ref.watch(selectedFileProvider);

    if (tabController?.length != openedFiles.length) {
      tabController = TabController(length: openedFiles.length, vsync: this);
    }

    if (selectedFile != null) {
      final selectedIndex = openedFiles.toList().indexOf(selectedFile);
      if (selectedIndex != -1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          tabController!.animateTo(selectedIndex);
        });
      }
    }

    final List<Widget> tabs = openedFiles
        .map(
          (file) => Tab(
            child: Row(
              children: [
                Text(file.split(Platform.pathSeparator).last),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    ref.read(openedFilesProvider.notifier).removeFile(file);
                  },
                ),
              ],
            ),
          ),
        )
        .toList();
    if (openedFiles.isNotEmpty) {
      tabController!.animateTo(openedFiles.length - 1);
    }

    return Scaffold(
      appBar: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        controller: tabController,
        tabs: tabs,
      ),
      body: TabBarView(
        controller: tabController,
        children:
            openedFiles.map((file) => EditPart(file: File(file))).toList(),
      ),
    );
  }
}
