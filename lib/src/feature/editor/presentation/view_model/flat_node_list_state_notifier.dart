import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/convert_document_line_use_case.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/save_document_use_case.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlatNodeListStateNotifier extends StateNotifier<List<Inline>> {
  Ref ref;

  FlatNodeListStateNotifier(this.ref) : super([]);

  List<Inline> getList() {
    return state;
  }

  int getListLength() {
    return state.length;
  }

  // ignore: use_setters_to_change_properties
  void updateList(List<Inline> list) {
    state = list;
  }

  Inline getNodeByIndex(int index) {
    return state[index];
  }

  void setNodeToEditingModeByIndex(int index, TapUpDetails details) {
    final List<Inline> list = [...state];
    resetFlatNodeListEditingMode();
    final Offset globalPosition = details.globalPosition;
    list[index].isEditing = true;
    list[index].controller.clear();
    list[index].controller.text = list[index].rawText;
    list[index].globalPosition = globalPosition;
    list[index].focusNode.requestFocus();
    state = list;
  }

  void setEditingNodeCursorPosition(int index) {
    final List<Inline> list = [...state];
    if (list[index].globalPosition != list[index].previousGlobalPosition) {
      list[index].previousGlobalPosition = list[index].globalPosition;
      final EditableTextState? editableTextState = list[index].key.currentState;
      final RenderEditable renderEditable = editableTextState!.renderEditable;
      final TextPosition textPosition =
          renderEditable.getPositionForPoint(list[index].globalPosition);
      list[index].controller.selection =
          TextSelection.collapsed(offset: textPosition.offset);
      state = list;
    }
  }

  void resetFlatNodeListEditingMode() {
    final List<Inline> list = [...state];
    for (int i = 0; i < state.length; i++) {
      list[i].controller.selection = const TextSelection.collapsed(offset: 0);
      list[i].isEditing = false;
    }
  }

  void updateNodeHeight(int index, BuildContext context) {
    final List<Inline> list = [...state];
    final text = list[index].controller.text;
    final style = list[index].style;
    final maxWidth = MediaQuery.of(context).size.width;

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    final newHeight = textPainter.height;

    if (list[index].style.height != newHeight) {
      list[index].textHeight = newHeight;
      state = list;
    }
  }

  void onChange(int index, String value) {
    final List<Inline> list = [...state];
    final ConvertStringToLineUseCase convertStringToLineUseCase =
        ref.read(convertStringToLineUseCaseProvider);
    final renderAdapter = ref.read(renderAdapterProvider);
    list[index] = convertStringToLineUseCase.convertLine(value);
    final instruction = list[index].render();
    final widget = renderAdapter.adapt(list[index], instruction);
    ref
        .read(widgetListStateNotifierProvider.notifier)
        .updateWidgetByIndex(index, widget);
    list[index].isEditing = true;
    list[index].focusNode.requestFocus();
    saveDocument(list);
    state = list;
  }

  void onEditingComplete(int index) {
    final List<Inline> list = [...state];
    final newNode = list[index].createNewLine();
    final renderAdapter = ref.read(renderAdapterProvider);
    if (index < list.length - 1) {
      list.insert(index + 1, newNode);
      final instruction = list[index + 1].render();
      final widget = renderAdapter.adapt(list[index + 1], instruction);
      ref
          .read(widgetListStateNotifierProvider.notifier)
          .insertWidgetByIndex(index + 1, widget);

      list[index + 1].isEditing = true;
    } else {
      list.add(newNode);
      final instruction = newNode.render();
      final widget = renderAdapter.adapt(list[index + 1], instruction);
      ref.read(widgetListStateNotifierProvider.notifier).addWidget(widget);
      list[list.length - 1].isEditing = true;
    }

    list[index].isEditing = false;
    list[index + 1].focusNode.requestFocus();

    saveDocument(list);
    state = list;
  }

  void onDelete(int index) {
    final List<Inline> list = [...state];
    if (list[index].text.isEmpty && list[index].controller.text.isEmpty) {
      if (index > 0) {
        list.removeAt(index);
        ref
            .read(widgetListStateNotifierProvider.notifier)
            .removeWidgetByIndex(index);
        list[index - 1].isEditing = true;
        list[index - 1].controller.selection =
            TextSelection.collapsed(offset: list[index - 1].rawText.length);
        list[index - 1].focusNode.requestFocus();
        saveDocument(list);
      }
    }
    state = list;
  }

  void saveDocument(List<Inline> list) {
    final SaveDocumentUseCase saveDocumentUseCase =
        ref.read(saveDocumentUseCaseProvider);
    saveDocumentUseCase
        .saveDocument(list.map((node) => node.rawText).join('\n'));
  }

  void onSingleTapUp(int index, TapDragUpDetails details) {
    final List<Inline> list = [...state];
    final node = list[index];
    final nodeKey = node.key;
    final EditableTextState? editableTextState = nodeKey.currentState;
    if (index < 0 || index >= list.length) {
      return;
    }
    if (editableTextState == null) {
      return;
    }
    final RenderEditable renderEditable = editableTextState.renderEditable;
    try {
      resetFlatNodeListEditingMode();
      final TapDownDetails tapDownDetails =
          TapDownDetails(globalPosition: details.globalPosition);
      renderEditable.handleTapDown(tapDownDetails);
      renderEditable.selectWordEdge(cause: SelectionChangedCause.tap);
      editableTextState.hideToolbar();
      editableTextState.requestKeyboard();
    // ignore: empty_catches
    } catch (e) {}
    state = list;
  }

  void onDragSelectionStart(int index, TapDragStartDetails details) {
    final List<Inline> list = [...state];
    final currentNode = list[index];
    final RenderEditable renderEditable =
        currentNode.key.currentState!.renderEditable;
    renderEditable.selectPositionAt(
      from: details.globalPosition,
      cause: SelectionChangedCause.drag,
    );
  }

  void onDragSelectionUpdate(
    int index,
    TapDragUpdateDetails details,
    BuildContext context,
  ) {
    final List<Inline> list = [...state];
    final mouseIndex = getLineIndex(context, details.globalPosition.dy);

    if (mouseIndex == -1 || mouseIndex == index) {
      final renderEditable = list[index].key.currentState!.renderEditable;
      renderEditable.selectPositionAt(
        from: details.globalPosition - details.offsetFromOrigin,
        to: details.globalPosition,
        cause: SelectionChangedCause.drag,
      );
      return;
    }

    int lastMouseIndex = -1;
    bool isSelectingUp = false;

    final bool currentSelectingUp = mouseIndex < index;
    if (lastMouseIndex != -1 && currentSelectingUp != isSelectingUp) {
      for (final node in list) {
        node.isEditing = false;
        node.controller.selection = const TextSelection.collapsed(offset: 0);
      }
    }
    isSelectingUp = currentSelectingUp;
    lastMouseIndex = mouseIndex;
    final int startIndex = isSelectingUp ? mouseIndex : index;
    final int endIndex = isSelectingUp ? index : mouseIndex;
    for (int i = startIndex; i <= endIndex; i++) {
      list[i].isEditing = true;
      if (i == startIndex) {
        list[i].controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: list[i].controller.text.length,
        );
      } else if (i == endIndex) {
        list[i].controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: isSelectingUp
              ? list[i].controller.selection.extentOffset
              : list[i].controller.text.length,
        );
      } else {
        list[i].controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: list[i].controller.text.length,
        );
      }
    }
    for (int i = 0; i < list.length; i++) {
      if (i < startIndex || i > endIndex) {
        list[i].isEditing = false;
        list[i].controller.selection = const TextSelection.collapsed(offset: 0);
      }
    }
    state = list;
  }

  int getLineIndex(BuildContext context, double dy) {
    final scrollController2 = ref.watch(scrollController2Provider);
    final (visibleIndices, cumulativeHeights) = getVisibleNodeIndices(context);
    if (visibleIndices.isEmpty) return -1;
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return -1;
    final double verticalOffset = renderBox.localToGlobal(Offset.zero).dy;
    final double adjustedDy = dy - verticalOffset + scrollController2.offset;

    for (int i = 0; i < visibleIndices.length; i++) {
      if (adjustedDy <= cumulativeHeights[i]) {
        return visibleIndices[i];
      }
    }

    return visibleIndices.last;
  }

  (List<int>, List<double>) getVisibleNodeIndices(BuildContext context) {
    final scrollController2 = ref.watch(scrollController2Provider);
    if (scrollController2.positions.isEmpty) return ([], []);
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return ([], []);
    final double verticalOffset = renderBox.localToGlobal(Offset.zero).dy;
    final double scrollStart = scrollController2.offset - verticalOffset;
    final double scrollEnd =
        scrollStart + scrollController2.position.viewportDimension;
    final List<int> visibleIndices = [];
    final List<double> cumulativeHeights = [];
    double currentHeight = 0;

    for (int i = 0; i < state.length; i++) {
      currentHeight += state[i].textHeight;
      if (currentHeight >= scrollStart && currentHeight <= scrollEnd) {
        visibleIndices.add(i);
        cumulativeHeights.add(currentHeight);
      }
      if (currentHeight > scrollEnd) break;
    }

    return (visibleIndices, cumulativeHeights);
  }

  void selectAll() {
    final List<Inline> list = [...state];
    for (int i = 0; i < list.length; i++) {
      list[i].controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: list[i].rawText.length,
      );
    }
    state = list;
  }

  void onArrowUp(int index) {
    final List<Inline> list = [...state];
    if (index > 0) {
      resetFlatNodeListEditingMode();
      list[index - 1].isEditing = true;
      final int newOffset = list[index - 1].controller.text.length;
      list[index - 1].controller.selection =
          TextSelection.collapsed(offset: newOffset);
      list[index - 1].focusNode.requestFocus();
    }
    state = list;
  }

  void onArrowDown(int index) {
    final List<Inline> list = [...state];
    if (index < list.length - 1) {
      resetFlatNodeListEditingMode();
      list[index + 1].isEditing = true;
      final int newOffset = list[index + 1].controller.text.length;
      list[index + 1].controller.selection =
          TextSelection.collapsed(offset: newOffset);
      list[index + 1].focusNode.requestFocus();
    }
    state = list;
  }

  void onArrowLeft(int index, bool isShiftPressed) {
    handleArrowKey(index, true, isShiftPressed);
  }

  void onArrowRight(int index, bool isShiftPressed) {
    handleArrowKey(index, false, isShiftPressed);
  }

  void handleArrowKey(int index, bool isLeft, bool isShiftPressed) {
    if (isShiftPressed) {
      handleSelectionExtension(index, isLeft);
    } else {
      moveCursor(index, isLeft);
    }
  }

  void handleSelectionExtension(int index, bool isLeft) {}

  void moveCursor(int index, bool isLeft) {
    final List<Inline> list = [...state];
    if (isLeft &&
        list[index].controller.selection.baseOffset == 0 &&
        index > 0) {
      list[index].isEditing = false;
      list[index - 1].isEditing = true;
      list[index - 1].focusNode.requestFocus();
    } else if (!isLeft &&
        list[index].controller.selection.baseOffset ==
            list[index].rawText.length &&
        index < list.length - 1) {
      list[index].isEditing = false;
      list[index + 1].isEditing = true;
      list[index + 1].focusNode.requestFocus();
    }
    state = list;
  }

  void toggleNodeExpansion(int index) {
    final List<Inline> list = [...state];
    list[index].isExpanded = !list[index].isExpanded;
    for (final node in list) {
      if (node.parentKey == list[index].parentKey) {
        node.isExpanded = list[index].isExpanded;
      }
    }
    state = list;
  }
}
