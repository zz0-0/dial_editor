import 'dart:io';
import 'package:dial_editor/src/feature/editor/presentation/widget/edit_part_provider.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/presentation/screen/directory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectoryNodeWidget extends ConsumerStatefulWidget {
  final DirectoryNode node;

  const DirectoryNodeWidget({
    super.key,
    required this.node,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DirectoryNodeWidgetState();
}

class _DirectoryNodeWidgetState extends ConsumerState<DirectoryNodeWidget> {
  @override
  Widget build(BuildContext context) {
    final icon = isLeaf(widget.node)
        ? const Icon(Icons.abc)
        : isExpanded(widget.key!)
            ? const Icon(Icons.expand_more)
            : const Icon(Icons.chevron_right);

    return Column(
      children: [
        Row(
          children: [
            if (isLeaf(widget.node))
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: icon,
              )
            else
              IconButton(
                onPressed: onPressed,
                icon: icon,
              ),
            Flexible(
              child: widget.node.isDirectory
                  ? Text(
                      widget.node.content!,
                      style: const TextStyle(fontSize: 8),
                    )
                  : Material(
                      child: InkWell(
                        onTap: () {
                          final file = File(widget.node.path!);
                          ref.read(fileProvider.notifier).update(
                                (state) => file,
                              );
                          ref
                              .read(openedFilesProvider.notifier)
                              .addFile(widget.node.path!);
                        },
                        child: Text(
                          widget.node.content!,
                          style: const TextStyle(fontSize: 8),
                        ),
                      ),
                    ),
            ),
          ],
        ),
        if (isExpanded(widget.key!))
          Padding(
            padding: EdgeInsets.only(
              left: ref.watch(indentationProvider).toDouble(),
            ),
            child: ListView.builder(
              clipBehavior: Clip.antiAlias,
              shrinkWrap: true,
              itemCount: widget.node.children.length,
              itemBuilder: (context, index) {
                return DirectoryNodeWidget(
                  key: widget.node.children[index].key,
                  node: widget.node.children[index],
                );
              },
            ),
          ),
      ],
    );
  }

  bool isLeaf(DirectoryNode node) {
    return node.children.isEmpty;
  }

  bool isExpanded(Key key) {
    return ref.watch(directoryNodeExpandedProvider(key));
  }

  void onPressed() {
    ref
        .read(directoryNodeExpandedProvider(widget.key!).notifier)
        .update((state) {
      if (state) {
        return false;
      } else {
        return true;
      }
    });
  }
}
