import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NodeStateNotifier extends StateNotifier<List<Inline?>> {
  NodeStateNotifier(this.ref, this.key) : super([]);
  Ref ref;
  GlobalKey key;
  void initialize(Inline node) {
    final newNode = [node];
    state = newNode;
  }

  void updateNodeHeight(BuildContext context) {
    if (state[0] != null) {
      final node = state[0]!;
      final text = node.controller.text;
      final style = node.style;
      final maxWidth = MediaQuery.of(context).size.width;
      final textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: style,
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: maxWidth);
      final newHeight = textPainter.height;
      if (node.style.height != newHeight) {
        node.textHeight = newHeight;
        state = [node];
      }
    }
  }

  void setNodeToEditingMode() {
    final node = state[0]!..isEditing = true;
    node.controller.clear();
    node.controller.text = node.rawText;
    node.controller.selection =
        TextSelection.collapsed(offset: node.rawText.length);
    node.focusNode.requestFocus();
    state = [node];
  }

  void setNodeToEditingModeOnTap(Inline node, TapUpDetails details) {
    node.isEditing = true;
    node.controller.clear();
    node.controller.text = node.rawText;
    node.focusNode.requestFocus();
    state = [node];
  }

  void onChange(
    Inline node,
    String value,
    BuildContext context,
  ) {
    final convertStringToLineUseCase =
        ref.read(convertStringToLineUseCaseProvider);
    final cursorPosition = node.controller.selection.baseOffset;
    final newNode = convertStringToLineUseCase(value)
      ..key = node.key
      ..parentKey = node.parentKey;
    ref
        .read(nodeListStateNotifierProvider.notifier)
        .replaceNodeInBlock(node, newNode);
    state = [newNode];
    final instruction = newNode.render();
    final renderAdapter = ref.read(renderAdapterProvider);
    final widget = renderAdapter.adapt(newNode, instruction, context);
    if ((instruction as TextRenderInstruction).formatting !=
        MarkdownElement.emoji) {
      newNode.style = (widget as Text).style!;
    }
    updateNodeHeight(context);
    newNode.isEditing = true;
    newNode.focusNode.requestFocus();
    newNode.controller.selection =
        TextSelection.collapsed(offset: cursorPosition);
    state = [newNode];
  }

  void onEditingComplete(BuildContext context) {
    if (state[0] != null) {
      final node = state[0]!;
      final newNode = node.createNewLine();
      ref.read(nodeStateProvider(newNode.key).notifier).initialize(newNode);
      if (node.parentKey != null) {
        newNode.parentKey = node.parentKey;
        ref
            .read(nodeListStateNotifierProvider.notifier)
            .insertNodeToBlock(node, newNode);
      } else {
        ref
            .read(nodeListStateNotifierProvider.notifier)
            .insertNodeToRoot(node, newNode);
      }
      ref.read(nodeStateProvider(newNode.key).notifier).setNodeToEditingMode();
      node.isEditing = false;
      state = [node];
    }
  }

  void selectAll() {
    if (state[0] != null) {
      final node = state[0]!;
      state = [node];
    }
  }

  void onDelete() {
    if (state[0] != null) {
      final node = state[0]!;
      if (node.rawText.isEmpty) {
        final previousNode = ref
            .read(nodeListStateNotifierProvider.notifier)
            .getPreviousNode(node);
        if (node.parentKey != null) {
          ref
              .read(nodeListStateNotifierProvider.notifier)
              .removeNodeFromBlock(node);
        } else {
          ref
              .read(nodeListStateNotifierProvider.notifier)
              .removeNodeFromRoot(node);
        }
        if (previousNode != null) {
          ref
              .read(nodeStateProvider(previousNode.key).notifier)
              .setNodeToEditingMode();
        }
      }
      state = [node];
    }
  }

  void onArrowUp() {
    if (state[0] != null) {
      final node = state[0]!;
      final previousNode = ref
          .read(nodeListStateNotifierProvider.notifier)
          .getPreviousNode(node);
      if (previousNode != null) {
        node.isEditing = false;
        ref
            .read(nodeStateProvider(previousNode.key).notifier)
            .setNodeToEditingMode();
        state = [node];
      }
    }
  }

  void onArrowDown() {
    if (state[0] != null) {
      final node = state[0]!;
      final nextNode =
          ref.read(nodeListStateNotifierProvider.notifier).getNextNode(node);
      if (nextNode != null) {
        node.isEditing = false;
        ref
            .read(nodeStateProvider(nextNode.key).notifier)
            .setNodeToEditingMode();
        state = [node];
      }
    }
  }

  void onArrowLeft({required bool isShiftPressed}) {
    handleArrowKey(isLeft: true, isShiftPressed: isShiftPressed);
  }

  void onArrowRight({required bool isShiftPressed}) {
    handleArrowKey(isLeft: false, isShiftPressed: isShiftPressed);
  }

  void handleArrowKey({required bool isLeft, required bool isShiftPressed}) {
    if (isShiftPressed) {
      handleSelectionExtension(isLeft: isLeft);
    } else {
      moveCursor(isLeft: isLeft);
    }
  }

  void handleSelectionExtension({required bool isLeft}) {
    if (state[0] != null) {
      final node = state[0]!;
      final selection = node.controller.selection;
      if (isLeft && selection.extentOffset == 0) {
        final previousNode = ref
            .read(nodeListStateNotifierProvider.notifier)
            .getPreviousNode(node);
        if (previousNode != null) {
          final newOffset = previousNode.rawText.length;
          ref
              .read(nodeStateProvider(previousNode.key).notifier)
              .setNodeToEditingMode();
          previousNode.focusNode.requestFocus();
          previousNode.controller.selection =
              TextSelection.collapsed(offset: newOffset);
        }
      } else if (!isLeft && selection.extentOffset == node.rawText.length) {
        final nextNode =
            ref.read(nodeListStateNotifierProvider.notifier).getNextNode(node);
        if (nextNode != null) {
          ref
              .read(nodeStateProvider(nextNode.key).notifier)
              .setNodeToEditingMode();
          nextNode.focusNode.requestFocus();
          nextNode.controller.selection =
              const TextSelection.collapsed(offset: 0);
        }
      }
    }
  }

  void moveCursor({required bool isLeft}) {
    if (state[0] != null) {
      final node = state[0]!;
      final selection = node.controller.selection;
      if (isLeft && selection.baseOffset == 0) {
        final previousNode = ref
            .read(nodeListStateNotifierProvider.notifier)
            .getPreviousNode(node);
        if (previousNode != null) {
          final newOffset = previousNode.rawText.length;
          ref
              .read(nodeStateProvider(previousNode.key).notifier)
              .setNodeToEditingMode();
          previousNode.focusNode.requestFocus();
          previousNode.controller.selection =
              TextSelection.collapsed(offset: newOffset);
        }
      } else if (!isLeft && selection.baseOffset == node.rawText.length) {
        final nextNode =
            ref.read(nodeListStateNotifierProvider.notifier).getNextNode(node);
        if (nextNode != null) {
          ref
              .read(nodeStateProvider(nextNode.key).notifier)
              .setNodeToEditingMode();
          nextNode.focusNode.requestFocus();
          nextNode.controller.selection =
              const TextSelection.collapsed(offset: 0);
        }
      }
    }
  }

  void toggleNodeExpansion() {
    if (state[0] != null) {
      final node = state[0]!;
      if (node.isBlockStart) {
        ref
            .read(nodeListStateNotifierProvider.notifier)
            .toggleNodeExpansion(node);
        if (node.isExpanded) {
          ref.read(toggleNodeExpansionKeyProvider.notifier).state = node.key;
        } else {
          ref.read(toggleNodeExpansionKeyProvider.notifier).state = null;
        }
      }
      node.isExpanded = !node.isExpanded;
      state = [node];
    }
  }

  void onDragSelectionStart(TapDragStartDetails details) {
    ref.read(nodeListStateNotifierProvider.notifier).clearSelection();
  }

  void clearSelection() {
    if (state[0] != null) {
      final node = state[0]!;
      node.controller.selection = const TextSelection.collapsed(offset: 0);
      state = [node];
    }
  }

  void onDragSelectionUpdate(TapDragUpdateDetails details) {
    if (state[0] != null) {
      final node = state[0]!;
      final lineNumberDiff =
          _getLineNumberDiff(node, details.offsetFromOrigin.dy);
      if (lineNumberDiff == -1 || lineNumberDiff == 0) {
        node.key.currentState!.renderEditable.selectPositionAt(
          from: details.globalPosition - details.offsetFromOrigin,
          to: details.globalPosition,
          cause: SelectionChangedCause.drag,
        );
        return;
      }
      if (lineNumberDiff < 0) {
        var currentNode = node;
        for (var i = 0; i < -lineNumberDiff; i++) {
          final previousNode = ref
              .read(nodeListStateNotifierProvider.notifier)
              .getPreviousNode(currentNode);
          if (previousNode != null) {
            ref
                .read(nodeStateProvider(previousNode.key).notifier)
                .setNodeToEditingMode();
            previousNode.controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: i == -lineNumberDiff - 1
                  ? previousNode.controller.selection.extentOffset
                  : previousNode.controller.text.length,
            );
            currentNode = previousNode;
          }
        }
      } else if (lineNumberDiff > 0) {
        var currentNode = node;
        for (var i = 0; i < lineNumberDiff; i++) {
          final nextNode = ref
              .read(nodeListStateNotifierProvider.notifier)
              .getNextNode(currentNode);
          if (nextNode != null) {
            ref
                .read(nodeStateProvider(nextNode.key).notifier)
                .setNodeToEditingMode();
            nextNode.controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: i == lineNumberDiff - 1
                  ? nextNode.controller.selection.extentOffset
                  : nextNode.controller.text.length,
            );
            currentNode = nextNode;
          }
        }
      }
    }
  }

  int _getLineNumberDiff(Inline node, double dy) {
    var currentNode = node;
    var count = 0;
    var height = dy;
    if (height < 0) {
      while (height < 0) {
        final previousNode = ref
            .read(nodeListStateNotifierProvider.notifier)
            .getPreviousNode(currentNode);
        if (previousNode == null) {
          break;
        }
        height += previousNode.textHeight!;
        count--;
        currentNode = previousNode;
      }
    } else {
      while (height > 0) {
        final nextNode = ref
            .read(nodeListStateNotifierProvider.notifier)
            .getNextNode(currentNode);
        if (nextNode == null) {
          break;
        }
        height -= nextNode.textHeight!;
        count++;
        currentNode = nextNode;
      }
    }
    return count;
  }
}
