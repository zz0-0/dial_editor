import 'dart:io';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/infinite_canvas.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/file_view.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/file_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum View { file, canvas }

class TabPart extends ConsumerStatefulWidget {
  const TabPart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabPartState();
}

class _TabPartState extends ConsumerState<TabPart>
    with TickerProviderStateMixin {
  TabController? tabController;
  View view = View.file;

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
        children: openedFiles
            .map(
              (file) => Column(
                children: [
                  SegmentedButton<View>(
                    segments: const [
                      ButtonSegment(
                        value: View.file,
                        label: Text('File'),
                        icon: Icon(Icons.file_open),
                      ),
                      ButtonSegment(
                        value: View.canvas,
                        label: Text('Canvas'),
                        icon: Icon(Icons.account_tree),
                      ),
                    ],
                    selected: {view},
                    onSelectionChanged: (Set<View> newView) {
                      setState(() {
                        view = newView.first;
                      });
                    },
                  ),
                  if (view == View.file)
                    Expanded(child: FileView(file: File(file))),
                  if (view == View.canvas)
                    const Expanded(child: InfiniteCanvas()),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
