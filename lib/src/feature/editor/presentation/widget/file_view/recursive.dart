import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/attribute_button.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/editing.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/expand.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/line_number.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Recursive extends ConsumerStatefulWidget {
  const Recursive(this.node, this.index, {super.key});
  final Node node;
  final int index;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecursiveState();
}

class _RecursiveState extends ConsumerState<Recursive> {
  bool isTapping = false;
  bool isInlineTapping = false;
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    var currentIndex = widget.index;
    if (widget.node is Block) {
      ref
          .read(nodeListStateNotifierProvider.notifier)
          .insertBlockNodeIntoMap(widget.node.key, widget.node as Block);
      return InkWell(
        focusNode: focusNode,
        onTap: () {},
        child: TapRegion(
          onTapInside: (event) {
            setState(() {
              isTapping = true;
            });
          },
          onTapOutside: (event) {
            focusNode.unfocus();
            setState(() {
              isTapping = false;
            });
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (widget.node as Block).children.map((child) {
                    final widget = Recursive(child, currentIndex);
                    if (child is Block) {
                      currentIndex += child.children.length;
                    } else {
                      currentIndex++;
                    }
                    return widget;
                  }).toList(),
                ),
              ),
              if (isTapping) AttributeButton(widget.node),
            ],
          ),
        ),
      );
    } else if (widget.node is Inline) {
      final inlineNode = widget.node as Inline;
      final updatedNode = ref.watch(nodeStateProvider(inlineNode.key));
      if (updatedNode.isEmpty) {
        updatedNode.add(inlineNode);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref
              .read(nodeStateProvider(widget.node.key).notifier)
              .initialize(inlineNode);
          ref
              .read(nodeListStateNotifierProvider.notifier)
              .insertNodeIntoFlatNodeList(inlineNode);
        });
      }
      return _buildInlineContent(context, ref, updatedNode[0]!, currentIndex);
    }
    return Container();
  }

  bool _shouldExpanded(WidgetRef ref, Inline inline) {
    final expansionKey = ref.watch(toggleNodeExpansionKeyProvider);
    if (inline.isBlockStart) {
      if (inline.key == expansionKey) {
        return true;
      }
      return inline.isExpanded || expansionKey == null;
    } else {
      return inline.isExpanded &&
          (expansionKey == null || expansionKey != inline.parentKey);
    }
  }

  Widget _buildInlineContent(
    BuildContext context,
    WidgetRef ref,
    Inline inline,
    int currentIndex,
  ) {
    return _shouldExpanded(ref, inline)
        ? InkWell(
            onTap: () {},
            child: TapRegion(
              onTapInside: (event) {
                setState(() {
                  isInlineTapping = true;
                });
              },
              onTapOutside: (event) {
                focusNode.unfocus();
                setState(() {
                  isInlineTapping = false;
                });
              },
              child: Row(
                children: [
                  LineNumber(inline, currentIndex),
                  Expand(inline),
                  Expanded(
                    child: inline.isEditing
                        ? Row(
                            children: [
                              Expanded(
                                child: Editing(inline),
                              ),
                              if (isInlineTapping) AttributeButton(inline),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(child: Rendering(inline)),
                              if (isInlineTapping) AttributeButton(inline),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
