import 'dart:io';

import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/document_codec.dart';
import 'package:dial_editor/src/feature/editor/util/markdown_render.dart';
import 'package:dial_editor/src/feature/editor/util/string_to_document_converter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:logger/logger.dart';

class EditPart extends ConsumerStatefulWidget {
  final File file;
  const EditPart({super.key, required this.file});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPartState();
}

class _EditPartState extends ConsumerState<EditPart>
    implements TextSelectionGestureDetectorBuilderDelegate {
  // Logger logger = Logger();
  late Document document;
  late String fileString;
  List<Node> nodes = [];
  List<Widget> markdownWidgetList = [];
  final GlobalKey<EditableTextState> _editorKey =
      GlobalKey<EditableTextState>();
  List<double> cumulativeHeights = [];

  @override
  GlobalKey<EditableTextState> get editableTextKey => _editorKey;

  @override
  bool get forcePressEnabled => false;

  @override
  bool get selectionEnabled => true;

  @override
  void initState() {
    super.initState();
    fileString = widget.file.readAsStringSync();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    document = DocumentCodec(context).encode(fileString);
    nodes = document.children;
    markdownWidgetList = MarkdownRender().renderList(nodes);
    _setCumulativeHeights();
  }

  @override
  void dispose() {
    super.dispose();
    for (final node in nodes) {
      node.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            _buildLineNumber(),
            _buildEditingArea(),
          ],
        ),
      ],
    );
  }

  void _setCumulativeHeights() {
    double currentHeight = 0.0;
    for (final node in nodes) {
      currentHeight += node.textHeight;
      cumulativeHeights.add(currentHeight);
    }
  }

  int _getLineIndex(double dy) {
    for (int i = 0; i < cumulativeHeights.length; i++) {
      if (dy <= cumulativeHeights[i]) {
        return i - 1;
      }
    }
    return -1;
  }

  Widget _buildLineNumber() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: SizedBox(
        width: 30,
        child: ListView.builder(
          itemCount: nodes.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                const Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  height: nodes[index].textHeight,
                  child: Text(
                    "${index + 1}",
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEditingArea() {
    return Expanded(
      child: ListView.builder(
        itemCount: nodes.length,
        itemBuilder: (context, index) {
          return nodes[index].isEditing
              ? _buildEditingWidget(index)
              : _buildRenderingWidget(index);
        },
      ),
    );
  }

  Widget _buildEditingWidget(int index) {
    final CustomTextSelectionGestureDetectorBuilder builder =
        CustomTextSelectionGestureDetectorBuilder(
      state: this,
      index: index,
    );

    return builder.buildGestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Focus(
        onFocusChange: (hasFocus) {},
        onKeyEvent: (node, event) => _onKeyEvent(event, index),
        child: GestureDetector(
          child: EditableText(
            key: nodes[index].key,
            controller: nodes[index].controller,
            focusNode: nodes[index].focusNode,
            cursorColor: Colors.blue,
            backgroundCursorColor: Colors.blue,
            style: nodes[index].style,
            selectionControls: MaterialTextSelectionControls(),
            onChanged: (value) {
              _onChange(index, value);
            },
            onEditingComplete: () {
              _onEditingComplete(index);
            },
            showCursor: true,
            selectionColor: Colors.red,
            rendererIgnoresPointer: true,
            enableInteractiveSelection: true,
            paintCursorAboveText: true,
          ),
        ),
      ),
    );
  }

  void _onSingleTapUp(int index, TapDragUpDetails details) {
    // logger.d("_onSingleTapUp called for index: $index");

    if (index < 0 || index >= nodes.length) {
      // logger.d("Error: Invalid index $index. Nodes length: ${nodes.length}");
      return;
    }

    final node = nodes[index];
    final nodeKey = node.key;
    final EditableTextState? editableTextState = nodeKey.currentState;
    if (editableTextState == null) {
      // logger.d("Error: EditableTextState is null for node at index $index");
      return;
    }

    final RenderEditable renderEditable = editableTextState.renderEditable;

    try {
      _resetAll();
      final TapDownDetails tapDownDetails =
          TapDownDetails(globalPosition: details.globalPosition);
      renderEditable.handleTapDown(tapDownDetails);
      renderEditable.selectWordEdge(cause: SelectionChangedCause.tap);
      editableTextState.hideToolbar();
      editableTextState.requestKeyboard();
      // logger.d("_onSingleTapUp completed successfully for index: $index");
    } catch (e) {
      // logger.d("Error during tap handling for node at index $index: $e");
    }
  }

  void _onDragSelectionStart(int index, TapDragStartDetails details) {
    final RenderEditable renderEditable =
        nodes[index].key.currentState!.renderEditable;

    renderEditable.selectPositionAt(
      from: details.globalPosition,
      cause: SelectionChangedCause.drag,
    );
  }

  void _onDragSelectionUpdate(
    int index,
    TapDragUpdateDetails details,
  ) {
    final nodeKey = nodes[index].key;

    final EditableTextState? editableTextState = nodeKey.currentState;
    if (editableTextState == null) {
      // logger.d('Error: EditableTextState is null for node at index $index');
      return;
    }

    final renderEditable = editableTextState.renderEditable;

    renderEditable.selectPositionAt(
      from: details.globalPosition - details.offsetFromOrigin,
      to: details.globalPosition,
      cause: SelectionChangedCause.drag,
    );

    final currentNode = nodes[index];

    final int extentOffset = currentNode.controller.selection.extentOffset;

    final mouseIndex = _getLineIndex(details.globalPosition.dy);

    if (extentOffset <= 0 && index > 0) {
      setState(() {
        final previousNode = nodes[index - 1];
        previousNode.isEditing = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          previousNode.focusNode.requestFocus();
          previousNode.controller.selection = TextSelection.collapsed(
            offset: previousNode.controller.text.length,
          );
          if (index - 1 >= mouseIndex) {
            _onDragSelectionUpdate(index - 1, details);
          }
        });
      });
    } else if (extentOffset >= currentNode.controller.text.length &&
        index < nodes.length - 1) {
      setState(() {
        final nextNode = nodes[index + 1];
        nextNode.isEditing = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nextNode.focusNode.requestFocus();
          nextNode.controller.selection =
              const TextSelection.collapsed(offset: 0);
          if (index + 1 <= mouseIndex) {
            _onDragSelectionUpdate(index + 1, details);
          }
        });
      });
    }
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

  void _onChange(int index, String value) {
    final currentSelection = nodes[index].controller.selection;
    setState(() {
      nodes[index] = StringToDocumentConverter(context).convertLine(value);
      markdownWidgetList[index] = MarkdownRender().render(nodes[index]);
      nodes[index].isEditing = true;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        nodes[index].controller.selection = currentSelection;
        nodes[index].focusNode.requestFocus();
      });
      _updateDocument();
    });
  }

  void _onEditingComplete(int index) {
    setState(() {
      markdownWidgetList[index] = MarkdownRender().render(nodes[index]);

      final newNode = nodes[index].createNewLine();

      if (index < nodes.length - 1) {
        nodes.insert(index + 1, newNode);
        markdownWidgetList.insert(
          index + 1,
          MarkdownRender().render(nodes[index + 1]),
        );

        nodes[index + 1].isEditing = true;
      } else {
        nodes.add(newNode);
        markdownWidgetList.add(
          MarkdownRender().render(nodes[index + 1]),
        );
        nodes[nodes.length - 1].isEditing = true;
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        nodes[index + 1].focusNode.requestFocus();
      });
      _updateDocument();
    });
  }

  void _updateDocument() {
    fileString = document.toString();
    widget.file.writeAsStringSync(fileString);
    _setCumulativeHeights();
  }

  Widget _buildRenderingWidget(int index) {
    return GestureDetector(
      onTapUp: (details) {
        _resetAll();
        setState(() {
          nodes[index].isEditing = true;
          nodes[index].controller.clear();
          nodes[index].controller.text = nodes[index].rawText;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            nodes[index].focusNode.requestFocus();
          });
        });
      },
      child: markdownWidgetList[index],
    );
  }

  void _selectAll(int index) {
    setState(() {
      for (var i = 0; i < nodes.length; i++) {
        nodes[i].isEditing = true;
        nodes[i].controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: nodes[i].controller.text.length,
        );
      }
    });
  }

  void _onDelete(int index) {
    if (nodes[index].text.isEmpty && nodes[index].controller.text.isEmpty) {
      if (index > 0) {
        setState(() {
          nodes.removeAt(index);
          markdownWidgetList.removeAt(index);

          nodes[index - 1].isEditing = true;
          fileString = document.toString();
          widget.file.writeAsStringSync(fileString);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            nodes[index - 1].focusNode.requestFocus();
          });
          _updateDocument();
        });
      }
    }
  }

  void _onArrowUp(int index) {
    if (index > 0) {
      setState(() {
        _resetAll();
        nodes[index].isEditing = false;
        nodes[index - 1].isEditing = true;
        nodes[index].controller.text = nodes[index].rawText;
        nodes[index].controller.selection = TextSelection.fromPosition(
          TextPosition(offset: nodes[index].controller.text.length),
        );
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index - 1].focusNode.requestFocus();
        });
      });
    }
  }

  void _onArrowDown(int index) {
    if (index < nodes.length - 1) {
      setState(() {
        _resetAll();
        nodes[index].isEditing = false;
        nodes[index + 1].isEditing = true;
        nodes[index].controller.text = nodes[index].rawText;
        nodes[index].controller.selection = TextSelection.fromPosition(
          TextPosition(offset: nodes[index].controller.text.length),
        );
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index + 1].focusNode.requestFocus();
        });
      });
    }
  }

  void _onArrowLeft(int index, bool isShiftPressed) {
    _handleArrowKey(index, true, isShiftPressed);
  }

  void _onArrowRight(int index, bool isShiftPressed) {
    _handleArrowKey(index, false, isShiftPressed);
  }

  void _resetAll() {
    for (int i = 0; i < nodes.length; i++) {
      nodes[i].controller.selection = const TextSelection.collapsed(offset: 0);
      nodes[i].isEditing = false;
    }
  }

  void _handleArrowKey(int index, bool isLeft, bool isShiftPressed) {
    if (isShiftPressed) {
      _handleSelectionExtension(index, isLeft);
    } else {
      _moveCursor(index, isLeft);
    }
  }

  void _handleSelectionExtension(int index, bool isLeft) {
    final currentNode = nodes[index];
    final selection = currentNode.controller.selection;

    if (isLeft && selection.extentOffset == 0 && index > 0) {
      setState(() {
        final int newOffset = nodes[index - 1].rawText.length;
        nodes[index - 1].isEditing = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index - 1].focusNode.requestFocus();
          nodes[index - 1].controller.selection =
              TextSelection.collapsed(offset: newOffset);
          nodes[index].controller.selection = selection;
        });
      });
    } else if (!isLeft &&
        selection.extentOffset == currentNode.rawText.length &&
        index < nodes.length - 1) {
      setState(() {
        nodes[index + 1].isEditing = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index + 1].focusNode.requestFocus();
          nodes[index].controller.selection = selection;
        });
      });
    }
  }

  void _moveCursor(int index, bool isLeft) {
    final currentNode = nodes[index];
    final selection = currentNode.controller.selection;

    setState(() {
      if (isLeft && selection.baseOffset == 0 && index > 0) {
        nodes[index - 1].isEditing = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index - 1].focusNode.requestFocus();
        });
      } else if (!isLeft &&
          selection.baseOffset == currentNode.rawText.length &&
          index < nodes.length - 1) {
        nodes[index + 1].isEditing = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index + 1].focusNode.requestFocus();
        });
      }
    });
  }
}

class CustomTextSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  final _EditPartState _state;
  final int _index;

  CustomTextSelectionGestureDetectorBuilder({
    required _EditPartState state,
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
