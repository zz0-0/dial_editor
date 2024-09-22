import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/node_state_notifier.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Editing extends ConsumerStatefulWidget {
  final Inline node;
  const Editing(this.node, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditingState();
}

class _EditingState extends ConsumerState<Editing>
    implements TextSelectionGestureDetectorBuilderDelegate {
  late NodeStateNotifier nodeStateNotifier;
  final GlobalKey<EditableTextState> _editorKey =
      GlobalKey<EditableTextState>();

  @override
  GlobalKey<EditableTextState> get editableTextKey => _editorKey;

  @override
  bool get forcePressEnabled => false;

  @override
  bool get selectionEnabled => false;

  @override
  Widget build(BuildContext context) {
    nodeStateNotifier = ref.read(nodeStateProvider(widget.node.key).notifier);
    final CustomTextSelectionGestureDetectorBuilder
        selectionGestureDetectorBuilder =
        CustomTextSelectionGestureDetectorBuilder(state: this);

    return selectionGestureDetectorBuilder.buildGestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Focus(
        onKeyEvent: (node, event) => _onKeyEvent(event, widget.node),
        child: GestureDetector(
          child: ValueListenableBuilder(
            valueListenable: widget.node.controller,
            builder: (context, value, child) {
              return EditableText(
                key: widget.node.key,
                controller: widget.node.controller,
                focusNode: widget.node.focusNode,
                style: widget.node.style,
                cursorColor: Colors.blue,
                backgroundCursorColor: Colors.blue,
                showCursor: true,
                selectionColor: Colors.red,
                enableInteractiveSelection: true,
                paintCursorAboveText: true,
                onChanged: (value) => _onChange(widget.node, value, context),
                onSubmitted: (_) => _onEditingComplete(context),
                textInputAction: TextInputAction.done,
              );
            },
          ),
        ),
      ),
    );
  }

  KeyEventResult _onKeyEvent(KeyEvent event, Inline node) {
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.keyA &&
        HardwareKeyboard.instance.isControlPressed) {
      _selectAll();
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      _onDelete();
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _onArrowUp();
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _onArrowDown();
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _onArrowLeft(HardwareKeyboard.instance.isShiftPressed);
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowRight) {
      _onArrowRight(HardwareKeyboard.instance.isShiftPressed);
    }
    // if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
    //         event.logicalKey == LogicalKeyboardKey.enter ||
    //     event.logicalKey == LogicalKeyboardKey.numpadEnter) {
    //   _onEditingComplete(context);
    // }
    return KeyEventResult.ignored;
  }

  void _onChange(
    Inline node,
    String value,
    BuildContext context,
  ) {
    nodeStateNotifier.onChange(node, value, context);
  }

  void _onEditingComplete(BuildContext context) {
    nodeStateNotifier.onEditingComplete(context);
  }

  void _selectAll() {
    nodeStateNotifier.selectAll();
  }

  void _onDelete() {
    nodeStateNotifier.onDelete();
  }

  void _onArrowUp() {
    nodeStateNotifier.onArrowUp();
  }

  void _onArrowDown() {
    nodeStateNotifier.onArrowDown();
  }

  void _onArrowLeft(bool isShiftPressed) {
    nodeStateNotifier.onArrowLeft(isShiftPressed);
  }

  void _onArrowRight(bool isShiftPressed) {
    nodeStateNotifier.onArrowRight(isShiftPressed);
  }

  void _onDragSelectionUpdate(TapDragUpdateDetails details) {
    nodeStateNotifier.onDragSelectionUpdate(details);
  }

  void _onDragSelectionStart(TapDragStartDetails details) {
    nodeStateNotifier.onDragSelectionStart(details);
  }
}

class CustomTextSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  final _EditingState state;
  CustomTextSelectionGestureDetectorBuilder({required this.state})
      : super(delegate: state);

  @override
  void onDragSelectionStart(TapDragStartDetails details) {
    state._onDragSelectionStart(details);
  }

  @override
  void onDragSelectionUpdate(TapDragUpdateDetails details) {
    state._onDragSelectionUpdate(details);
  }
}
