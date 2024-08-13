import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/convert_document_line_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NodeStateNotifier extends StateNotifier<List<Inline?>> {
  Ref ref;
  GlobalKey key;
  NodeStateNotifier(this.ref, this.key) : super([]);

  void initialize(Inline node) {
    final newNode = [node];
    state = newNode;
  }

  void updateNodeHeight(BuildContext context) {
    if (state[0] != null) {
      final Inline node = state[0]!;
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

  void setNodeToEditingModeByIndex(Inline node, TapUpDetails details) {
    final Offset globalPosition = details.globalPosition;
    node.isEditing = true;
    node.controller.clear();
    node.controller.text = node.rawText;
    node.globalPosition = globalPosition;
    node.focusNode.requestFocus();
    state = [node];
  }

  void onChange(
    Inline node,
    String value,
    BuildContext context,
  ) {
    final ConvertStringToLineUseCase convertStringToLineUseCase =
        ref.read(convertStringToLineUseCaseProvider);
    final int cursorPosition = node.controller.selection.baseOffset;
    final Inline temp = convertStringToLineUseCase.convertLine(value);
    temp.key = node.key;
    state = [temp];
    final instruction = temp.render();
    final renderAdapter = ref.read(renderAdapterProvider);
    final widget = renderAdapter.adapt(temp, instruction, context);
    temp.style = widget.style!;
    updateNodeHeight(context);
    temp.isEditing = true;
    temp.focusNode.requestFocus();
    temp.controller.selection = TextSelection.collapsed(offset: cursorPosition);
    state = [temp];
  }

  void onEditingComplete() {
    if (state[0] != null) {
      final Inline node = state[0]!;
      state = [node];
    }
  }

  void selectAll() {
    if (state[0] != null) {
      final Inline node = state[0]!;
      state = [node];
    }
  }

  void onDelete() {
    if (state[0] != null) {
      final Inline node = state[0]!;
      state = [node];
    }
  }

  void onArrowUp() {
    if (state[0] != null) {
      final Inline node = state[0]!;
      state = [node];
    }
  }

  void onArrowDown() {
    if (state[0] != null) {
      final Inline node = state[0]!;
      state = [node];
    }
  }

  void onArrowLeft(bool isShiftPressed) {
    if (state[0] != null) {
      final Inline node = state[0]!;
      state = [node];
    }
  }

  void onArrowRight(bool isShiftPressed) {
    if (state[0] != null) {
      final Inline node = state[0]!;
      state = [node];
    }
  }

  void toggleNodeExpansion() {
    if (state[0] != null) {
      final Inline node = state[0]!;
      if (node.isBlockStart) {
        ref
            .read(nodeListStateNotifierProvider.notifier)
            .toggleNodeExpansion(node);
      }
      node.isExpanded = !node.isExpanded;
      state = [node];
    }
  }
}
