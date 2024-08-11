import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/flat_node_list_state_notifier.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Editing extends ConsumerStatefulWidget {
  final int index;

  const Editing(this.index, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => EditingState();
}

class EditingState extends ConsumerState<Editing>
    implements TextSelectionGestureDetectorBuilderDelegate {
  final GlobalKey<EditableTextState> _editorKey =
      GlobalKey<EditableTextState>();

  late FlatNodeListStateNotifier flatNodeListStateNotifier;

  @override
  GlobalKey<EditableTextState> get editableTextKey => _editorKey;
  @override
  bool get forcePressEnabled => false;
  @override
  bool get selectionEnabled => true;

  @override
  Widget build(BuildContext context) {
    flatNodeListStateNotifier =
        ref.read(flatNodeListStateNotifierProvider.notifier);
    final node = flatNodeListStateNotifier.getNodeByIndex(widget.index);

    final CustomTextSelectionGestureDetectorBuilder builder =
        CustomTextSelectionGestureDetectorBuilder(
      state: this,
      index: widget.index,
    );
    return builder.buildGestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Focus(
        onFocusChange: (hasFocus) {
          if (hasFocus) {
            setState(() {
              _setEditingNodeCursorPosition(widget.index);
            });
          }
        },
        onKeyEvent: (node, event) => _onKeyEvent(event, widget.index),
        child: GestureDetector(
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: node.controller,
            builder: (context, value, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _updateNodeHeight(widget.index, context);
              });
              return EditableText(
                key: node.key,
                controller: node.controller,
                focusNode: node.focusNode,
                cursorColor: Colors.blue,
                backgroundCursorColor: Colors.blue,
                style: node.style,
                showCursor: true,
                selectionColor: Colors.red,
                enableInteractiveSelection: true,
                paintCursorAboveText: true,
                onChanged: (value) {
                  _onChange(
                    widget.index,
                    value,
                    // node is CodeLine || node is CodeBlockMarker,
                  );
                },
                onEditingComplete: () {
                  _onEditingComplete(widget.index);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  KeyEventResult _onKeyEvent(KeyEvent event, int index) {
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.keyA &&
        HardwareKeyboard.instance.isControlPressed) {
      _selectAll(index);
    }

    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      _onDelete(index);
    }

    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _onArrowUp(index);
    }

    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _onArrowDown(index);
    }

    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _onArrowLeft(index, HardwareKeyboard.instance.isShiftPressed);
    }

    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowRight) {
      _onArrowRight(index, HardwareKeyboard.instance.isShiftPressed);
    }

    return KeyEventResult.ignored;
  }

  void _updateNodeHeight(int index, BuildContext context) {
    flatNodeListStateNotifier.updateNodeHeight(index, context);
  }

  void _onChange(int index, String value) {
    flatNodeListStateNotifier.onChange(index, value);
  }

  void _onEditingComplete(int index) {
    flatNodeListStateNotifier.onEditingComplete(index);
  }

  void _onSingleTapUp(int index, TapDragUpDetails details) {
    flatNodeListStateNotifier.onSingleTapUp(index, details);
  }

  void _onDragSelectionStart(int index, TapDragStartDetails details) {
    flatNodeListStateNotifier.onDragSelectionStart(index, details);
  }

  void _onDragSelectionUpdate(int index, TapDragUpdateDetails details) {
    flatNodeListStateNotifier.onDragSelectionUpdate(index, details, context);
  }

  void _selectAll(int index) {
    flatNodeListStateNotifier.selectAll();
  }

  void _onDelete(int index) {
    flatNodeListStateNotifier.onDelete(index);
  }

  void _onArrowUp(int index) {
    flatNodeListStateNotifier.onArrowUp(index);
  }

  void _onArrowDown(int index) {
    flatNodeListStateNotifier.onArrowDown(index);
  }

  void _onArrowLeft(int index, bool isShiftPressed) {
    flatNodeListStateNotifier.onArrowLeft(index, isShiftPressed);
  }

  void _onArrowRight(int index, bool isShiftPressed) {
    flatNodeListStateNotifier.onArrowRight(index, isShiftPressed);
  }

  void _setEditingNodeCursorPosition(int index) {
    flatNodeListStateNotifier.setEditingNodeCursorPosition(index);
  }
}

class CustomTextSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  final EditingState _state;
  final int _index;
  CustomTextSelectionGestureDetectorBuilder({
    required EditingState state,
    required int index,
  })  : _state = state,
        _index = index,
        super(delegate: state);

  @override
  RenderEditable get renderEditable =>
      _state.editableTextKey.currentState!.renderEditable;

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    _state._onSingleTapUp(_index, details);
  }

  @override
  void onTapDown(TapDragDownDetails details) {}

  @override
  void onDragSelectionStart(TapDragStartDetails details) {
    _state._onDragSelectionStart(_index, details);
  }

  @override
  void onDragSelectionUpdate(TapDragUpdateDetails details) {
    _state._onDragSelectionUpdate(_index, details);
  }
}
