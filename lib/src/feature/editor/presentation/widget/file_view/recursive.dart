import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/attribute_button.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/editing.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/expand.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/line_number.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A [ConsumerStatefulWidget] that represents a recursive widget structure.
///
/// This widget is designed to be used within a consumer context, allowing it
/// to listen to changes in the state and rebuild accordingly. It is typically
/// used to display a hierarchical or nested structure of widgets.
///
/// Usage:
/// ```dart
/// Recursive(
///   // parameters
/// );
/// ```
///
/// See also:
///
///  * [ConsumerStatefulWidget], which is the base class for this widget.
///  * [ConsumerState], which provides the state management for this widget.
class Recursive extends ConsumerStatefulWidget {
  /// A widget that represents a recursive structure.
  ///
  /// This widget takes a node and an index as parameters and displays
  /// them in a recursive manner.
  ///
  /// Parameters:
  /// - `node`: The node to be displayed.
  /// - `index`: The index of the node.
  const Recursive(this.node, this.index, {super.key});

  /// A node object representing a part of the document structure.
  /// This is used to manage and manipulate the hierarchical data within the
  /// editor.
  final Node node;

  /// The index of the current item in the list or collection.
  ///
  /// This integer value is used to identify the position of an item
  /// within a list or collection, allowing for operations such as
  /// retrieval, update, or deletion based on its position.
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
      return _buildNodeContent(context, ref, updatedNode[0]!, currentIndex);
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

  Widget _buildNodeContent(
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
