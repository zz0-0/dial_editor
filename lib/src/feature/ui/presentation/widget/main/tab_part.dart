import 'dart:io';

import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/provider/directory_provider.dart';
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
  List<File> openedFiles = [];
  TabController? tabController;
  // final List<Widget> editPartList = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 0, vsync: this);
  }

  // @override
  // void didUpdateWidget(covariant TabPart oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (openedFiles.length != tabController?.length) {
  //     tabController = TabController(length: openedFiles.length, vsync: this);
  //   }
  // }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(fileProvider, (prev, now) {
      setState(() {
        if (now != null && prev?.path != now.path) {
          ref.read(openedFilesProvider.notifier).addFile(now);
        }
      });
    });

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
              (file) => Tab(text: file.path.split(Platform.pathSeparator).last),
            )
            .toList(),
      ),
      body: TabBarView(
        controller: tabController,
        children: openedFiles.map((file) => EditPart(file: file)).toList(),
      ),
    );
  }
}

class OpenedFilesNotifier extends StateNotifier<List<File>> {
  OpenedFilesNotifier() : super([]);

  void addFile(File file) {
    state = [...state, file];
  }
}

final openedFilesProvider =
    StateNotifierProvider<OpenedFilesNotifier, List<File>>((ref) {
  return OpenedFilesNotifier();
});
