import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/attribute_button.dart';
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
  bool isInlineHovering = false;
  final controller = OverlayPortalController();
  final inlineController = OverlayPortalController();
  @override
  Widget build(BuildContext context) {
    int currentIndex = widget.index;
    if (widget.node is Block) {
      ref
          .read(nodeListStateNotifierProvider.notifier)
          .insertBlockNodeIntoMap(widget.node.key, widget.node as Block);
      return InkWell(
        onTap: () {},
        onHover: (isHovering) {
          if (isHovering) {
            setState(() => isHovering = true);
            controller.show();
          } else {
            setState(() => isHovering = false);
            controller.hide();
          }
        },
        child: OverlayPortal(
          controller: controller,
          overlayChildBuilder: (context1) {
            final RenderBox? renderBox =
                context.findRenderObject() as RenderBox?;
            final Offset position =
                renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
            return Positioned(
              top: position.dy - 30,
              right: 10,
              child: MouseRegion(
                onEnter: (_) {
                  setState(() => isHovering = true);
                  controller.show();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2.0,
                        vertical: 1,
                      ),
                      child: AttributeButton(
                        AttributeType.key,
                        widget.node,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2.0,
                        vertical: 1,
                      ),
                      child: AttributeButton(
                        AttributeType.incoming,
                        widget.node,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
        ? InkWell(
            onTap: () {},
            onHover: (isInlineHovering) {
              if (isInlineHovering) {
                setState(() => isInlineHovering = true);
                inlineController.show();
              } else {
                setState(() => isInlineHovering = false);
                inlineController.hide();
              }
            },
            child: OverlayPortal(
              controller: inlineController,
              overlayChildBuilder: (context1) {
                final RenderBox? renderBox =
                    context.findRenderObject() as RenderBox?;
                final size = renderBox?.size;
                final Offset position =
                    renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
                return Positioned(
                  top: position.dy + (size!.height / 2) - 35,
                  right: 200,
                  child: MouseRegion(
                    hitTestBehavior: HitTestBehavior.translucent,
                    onEnter: (_) {
                      setState(() => isInlineHovering = true);
                      inlineController.show();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2.0,
                            vertical: 1,
                          ),
                          child: AttributeButton(
                            AttributeType.key,
                            inline,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2.0,
                            vertical: 1,
                          ),
                          child: AttributeButton(
                            AttributeType.incoming,
                            inline,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  LineNumber(inline, currentIndex),
                  Expand(inline),
                  Expanded(
                    child:
                        inline.isEditing ? Editing(inline) : Rendering(inline),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
