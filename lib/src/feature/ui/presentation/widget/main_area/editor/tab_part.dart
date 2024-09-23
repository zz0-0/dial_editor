import 'dart:io';

import 'package:dial_editor/src/core/provider/ui/editor_provder.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/main_area/editor/canvas_view.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/main_area/editor/file_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Enum representing different views in the editor tab part.
///
/// This enum is used to switch between various views within the
/// main area of the editor. Each value corresponds to a specific
/// view that can be displayed.
///
/// Example usage:
///
/// ```dart
/// View currentView = View.someView;
/// switch (currentView) {
///   case View.someView:
///     // Handle someView
///     break;
///   case View.anotherView:
///     // Handle anotherView
///     break;
/// }
/// ```
enum View {
  /// Represents a file in the main area editor tab.
  ///
  /// This variable holds the reference to the file being edited or displayed
  /// in the main area of the editor tab.
  ///
  /// Example usage:
  /// ```dart
  /// // Access the file in the editor tab
  /// var currentFile = file;
  /// ```
  file,

  /// Represents the main canvas area within the editor tab part.
  /// This is where the primary drawing or editing actions take place.
  canvas
}

/// A widget that represents a tab part in the editor's main area.
///
/// This widget is a `ConsumerStatefulWidget`, which means it can listen to
/// changes in the state provided by a `Provider` and rebuild accordingly.
///
/// The `TabPart` widget is used to manage and display the content of a tab
/// within the editor's main area.
///
/// Usage:
/// ```dart
/// TabPart();
/// ```
///
/// Make sure to wrap this widget with a `Provider` to supply the necessary
/// state for it to consume.
class TabPart extends ConsumerStatefulWidget {
  /// A widget representing a part of the tab in the editor.
  ///
  /// This widget is used within the main area of the editor to display
  /// a specific part of the tab interface.
  ///
  /// {@category Widget}
  ///
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
    final selectedFile = ref.watch(selectedFileProvider);

    if (tabController?.length != openedFiles.length) {
      tabController = TabController(length: openedFiles.length, vsync: this);
    }

    if (selectedFile != null) {
      final selectedIndex = openedFiles.toList().indexOf(selectedFile);
      if (selectedIndex != -1) {
        tabController!.animateTo(selectedIndex);
      }
    }

    final List<Widget> tabs = openedFiles
        .map(
          (file) => Tab(
            child: Row(
              children: [
                Text(file.split(Platform.pathSeparator).last),
                IconButton(
                  splashRadius: 20,
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
                  if (view == View.file) const Expanded(child: FileView()),
                  if (view == View.canvas) const Expanded(child: CanvasView()),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
