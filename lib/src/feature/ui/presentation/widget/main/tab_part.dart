import 'dart:io';

import 'package:dial_editor/src/feature/ui/presentation/provider/edit_part_provider.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/main/edit_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabPart extends ConsumerStatefulWidget {
  const TabPart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabPartState();
}

class _TabPartState extends ConsumerState<TabPart>
    with TickerProviderStateMixin {
  Set<File> openedFiles = {};
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

    if (tabController?.length != openedFiles.length) {
      tabController = TabController(length: openedFiles.length, vsync: this);
    }

    return Scaffold(
      appBar: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        controller: tabController,
        tabs: openedFiles
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
            .toList(),
      ),
      body: TabBarView(
        controller: tabController,
        children:
            openedFiles.map((file) => EditPart(file: File(file))).toList(),
      ),
    );
  }
}
