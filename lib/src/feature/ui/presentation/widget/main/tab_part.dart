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
  @override
  Widget build(BuildContext context) {
    final file = ref.watch(fileProvider);
    final tabController = TabController(length: 1, vsync: this);

    return Scaffold(
      appBar: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        controller: tabController,
        tabs: [
          Tab(
            child: Text(file!.path.split(Platform.pathSeparator).last),
          ),
        ],
      ),
      body: TabBarView(controller: tabController, children: const [EditPart()]),
    );
  }
}
