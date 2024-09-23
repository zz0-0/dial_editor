import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A state notifier that manages a list of inline nodes.
///
/// This class extends [StateNotifier] and is responsible for managing the state
/// of a list of inline nodes, which can be nullable. It provides functionality
/// to update and notify listeners about changes in the state.
///
/// The state is represented as a list of [Inline?] objects, where each element
/// can be an instance of the [Inline] class or null.
class NodeStateNotifier extends StateNotifier<List<Inline?>> {
  /// Constructs a [NodeStateNotifier] with the given [ref] and [key].
  ///
  /// The [ref] parameter is a reference to the provider or context that this
  /// notifier will use.
  /// The [key] parameter is a unique identifier for this notifier instance.
  ///
  /// Initializes the state with an empty list.
  NodeStateNotifier(this.ref, this.key) : super([]);

  /// A reference to the provider container that allows access to other
  /// providers.
  ///
  /// This is typically used to read or watch other providers within the
  /// `NodeStateNotifier` class.
  ///
  /// Example usage:
  /// ```dart
  /// final someValue = ref.read(someProvider);
  /// ```
  Ref ref;

  /// A global key used to uniquely identify the widget associated with this
  /// notifier.
  /// This key can be used to access the widget's state and perform operations
  /// on it.
  GlobalKey key;

  /// Initializes the state with the given [node].
  ///
  /// This method sets up the necessary state for the provided [Inline] node.
  ///
  /// [node]: The Inline node to initialize the state with.
  void initialize(Inline node) {
    final newNode = [node];
    state = newNode;
  }

  /// Updates the height of a node within the editor.
  ///
  /// This method recalculates and sets the height of a node based on the
  /// current context. It ensures that the node's height is properly adjusted
  /// to fit the content or any other criteria defined within the method.
  ///
  /// [context] The BuildContext which provides access to the widget tree and
  /// other relevant information needed to update the node's height.
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

  /// Sets the current node to editing mode.
  ///
  /// This method changes the state of the node to indicate that it is
  /// currently being edited. It can be used to trigger UI updates or
  /// other logic that depends on the node's editing state.
  void setNodeToEditingMode() {
    final node = state[0]!..isEditing = true;
    node.controller.clear();
    node.controller.text = node.rawText;
    node.controller.selection =
        TextSelection.collapsed(offset: node.rawText.length);
    node.focusNode.requestFocus();
    state = [node];
  }

  /// Sets the given node to editing mode when it is tapped.
  ///
  /// This method is triggered by a tap gesture on the node.
  ///
  /// [node] The inline node that should be set to editing mode.
  /// [details] The details of the tap gesture.
  void setNodeToEditingModeOnTap(Inline node, TapUpDetails details) {
    node.isEditing = true;
    node.controller.clear();
    node.controller.text = node.rawText;
    node.focusNode.requestFocus();
    state = [node];
  }

  /// Handles changes in the node state.
  ///
  /// This method is triggered whenever there is a change in the node state.
  /// It performs necessary updates and notifies listeners about the change.
  ///
  /// You can use this method to handle any specific logic that needs to be
  /// executed when the node state changes.
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

  /// Called when the editing is complete.
  ///
  /// This method should be invoked to handle any finalization logic
  /// when the user has finished editing. It takes the [BuildContext]
  /// as a parameter to allow interaction with the widget tree.
  ///
  /// [context] - The build context of the widget.
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

  /// Selects all the content within the editor.
  ///
  /// This method highlights or selects all the text or nodes present
  /// in the editor, allowing for operations such as copying or formatting
  /// to be applied to the entire content.
  void selectAll() {
    if (state[0] != null) {
      final node = state[0]!;
      state = [node];
    }
  }

  /// Handles the deletion of a node.
  ///
  /// This method is responsible for performing the necessary actions
  /// when a node is deleted from the editor. It ensures that the node
  /// is properly removed and any associated resources are cleaned up.
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

  /// Handles the action when the up arrow key is pressed.
  ///
  /// This method is typically used to navigate or move the focus
  /// upwards in a list or a tree structure within the editor.
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

  /// Handles the action when the down arrow key is pressed.
  ///
  /// This method is typically used to navigate through a list or move the
  /// cursor down in a text editor.
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

  /// Handles the left arrow key press event.
  ///
  /// If [isShiftPressed] is true, it performs an action considering the shift
  /// key is pressed.
  ///
  /// [isShiftPressed] - A boolean indicating whether the shift key is pressed.
  void onArrowLeft({required bool isShiftPressed}) {
    handleArrowKey(isLeft: true, isShiftPressed: isShiftPressed);
  }

  /// Handles the action when the right arrow key is pressed.
  ///
  /// If [isShiftPressed] is `true`, it indicates that the Shift key is also
  /// pressed along with the right arrow key.
  ///
  /// [isShiftPressed] - A boolean value indicating whether the Shift key is
  /// pressed.
  void onArrowRight({required bool isShiftPressed}) {
    handleArrowKey(isLeft: false, isShiftPressed: isShiftPressed);
  }

  /// Handles the arrow key press events.
  ///
  /// This method processes the arrow key inputs and performs the necessary
  /// actions based on the direction and whether the shift key is pressed.
  ///
  /// [isLeft] specifies the direction of the arrow key press. If `true`, it
  /// indicates the left arrow key; otherwise, it indicates the right arrow key.
  ///
  /// [isShiftPressed] indicates whether the shift key is pressed during the
  /// arrow key press event. If `true`, the shift key is pressed; otherwise, it
  /// is not pressed.
  void handleArrowKey({required bool isLeft, required bool isShiftPressed}) {
    if (isShiftPressed) {
      handleSelectionExtension(isLeft: isLeft);
    } else {
      moveCursor(isLeft: isLeft);
    }
  }

  /// Handles the extension of the selection in the editor.
  ///
  /// This method adjusts the selection based on the direction specified.
  ///
  /// [isLeft] determines the direction of the selection extension.
  /// If `true`, the selection is extended to the left; otherwise, it is
  /// extended to the right.
  ///
  /// - Parameters:
  ///   - isLeft: A boolean indicating the direction of the selection extension.
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

  /// Moves the cursor in the editor.
  ///
  /// This method moves the cursor either to the left or right based on the
  /// [isLeft] parameter.
  ///
  /// - [isLeft]: A boolean value that determines the direction of the cursor
  ///   movement. If true, the cursor moves to the left; if false, the cursor
  ///   moves to the right.
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

  /// Toggles the expansion state of a node.
  ///
  /// This method switches the current state of a node between expanded and
  /// collapsed.
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

  /// Handles the start of a drag selection event.
  ///
  /// This method is triggered when a drag selection starts, providing the
  /// details of the drag start event.
  ///
  /// [details] contains information about the drag start event, such as the
  /// position where the drag started.
  void onDragSelectionStart(TapDragStartDetails details) {
    ref.read(nodeListStateNotifierProvider.notifier).clearSelection();
  }

  /// Clears the current selection in the editor.
  ///
  /// This method resets any selected text or nodes, effectively
  /// deselecting any highlighted content within the editor.
  void clearSelection() {
    if (state[0] != null) {
      final node = state[0]!;
      node.controller.selection = const TextSelection.collapsed(offset: 0);
      state = [node];
    }
  }

  /// Handles the update of a drag selection event.
  ///
  /// This method is called when there is an update in the drag selection,
  /// providing the details of the update.
  ///
  /// [details] contains information about the drag update event.
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
