import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/attribute_button.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/editing.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/expand.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/line_number.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Recursive extends ConsumerStatefulWidget {
  final Node node;
  final int index;
  const Recursive(this.node, this.index, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecursiveState();
}

class _RecursiveState extends ConsumerState<Recursive> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    int currentIndex = widget.index;
    if (widget.node is Block) {
      ref
          .read(nodeListStateNotifierProvider.notifier)
          .insertBlockNodeIntoMap(widget.node.key, widget.node as Block);
      return InkWell(
        onTap: () {},
        onHover: (value) {
          setState(() {
            isHovering = value;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(isHovering ? 4 : 0),
          decoration: BoxDecoration(
            color: isHovering ? Colors.black12 : null,
            borderRadius: BorderRadius.circular(15),
          ),
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
      );
    } else if (widget.node is Inline) {
      final inlineNode = widget.node as Inline;
      final List<Inline?> updatedNode =
          ref.watch(nodeStateProvider(inlineNode.key));
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
      return _buildNodeContent(context, ref, updatedNode[0]!, currentIndex);
    }
    return Container();
  }

  bool _shouldExpanded(WidgetRef ref, Inline inline) {
    if (ref.read(toggleNodeExpansionKeyProvider) == null) {
      if (inline.isBlockStart || (!inline.isBlockStart && inline.isExpanded)) {
        return true;
      } else {
        return false;
      }
    } else {
      if (inline.isBlockStart &&
          inline.key == ref.read(toggleNodeExpansionKeyProvider)) {
        return true;
      } else {
        return false;
      }
    }
  }

  Widget _buildNodeContent(
    BuildContext context,
    WidgetRef ref,
    Inline inline,
    int currentIndex,
  ) {
    return _shouldExpanded(ref, inline)
        ? Row(
            children: [
              LineNumber(inline, currentIndex),
              Expand(inline),
              Expanded(
                child: inline.isEditing
                    ? Row(
                        children: [
                          Expanded(child: Editing(inline)),
                        ],
                      )
                    : Row(
                        children: [
                          Rendering(inline),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  AttributeButton(
                                    inline.attribute.key.toString().substring(
                                          inline.attribute.key
                                                  .toString()
                                                  .length -
                                              7,
                                          inline.attribute.key
                                                  .toString()
                                                  .length -
                                              1,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
