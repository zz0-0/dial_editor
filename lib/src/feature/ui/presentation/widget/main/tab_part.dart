import 'dart:io';

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
    // ref.listen(fileProvider, (prev, now) {
    //   setState(() {
    //     ref.read(openedFilesProvider.notifier).addFile(now!);
    //     // print(ref.watch(openedFilesProvider));
    //   });
    // });

    // final file = ref.watch(fileProvider);
    // ref.read(openedFilesProvider.notifier).addFile(file!);

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
              (file) => Tab(text: file.split(Platform.pathSeparator).last),
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

class OpenedFilesNotifier extends StateNotifier<Set<String>> {
  OpenedFilesNotifier() : super({});

  void addFile(String filePath) {
    if (!state.contains(filePath)) {
      final current = Set<String>.from(state);
      current.add(filePath);
      state = current;
    }
  }
}

final openedFilesProvider =
    StateNotifierProvider<OpenedFilesNotifier, Set<String>>((ref) {
  return OpenedFilesNotifier();
});
