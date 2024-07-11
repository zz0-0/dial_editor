import 'package:dial_editor/src/feature/file_management/directory/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/domain/model/directory_node_provider.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/widget/directory_node_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Directory extends ConsumerStatefulWidget {
  const Directory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DirectoryState();
}

class _DirectoryState extends ConsumerState<Directory> {
  late List<DirectoryNode> nodes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateDirectoryPositions();
    });
  }

  void _updateDirectoryPositions() {
    setState(() {
      for (int i = 0; i < nodes.length; i++) {
        final RenderBox? box =
            nodes[i].key?.currentContext?.findRenderObject() as RenderBox?;
        if (box != null) {
          final Offset position = box.localToGlobal(Offset.zero);
          // print(position.dy);
          nodes[i] = nodes[i].copyWith(dy: position.dy - 10);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    nodes = ref.watch(directoryNodeListProvider);
    return SizedBox(
      width: 200,
      child: ListView.builder(
        clipBehavior: Clip.antiAlias,
        shrinkWrap: true,
        itemCount: nodes.length,
        itemBuilder: (context, index) {
          return DirectoryNodeWidget(
            key: nodes[index].key,
            node: nodes[index],
            dx: 30,
            dy: nodes[index].dy,
          );
        },
      ),
    );
  }
}
