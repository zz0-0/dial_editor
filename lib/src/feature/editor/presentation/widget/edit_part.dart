import 'dart:io';
import 'package:dial_editor/src/feature/editor/domain/entity/document.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/code_block_marker.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/code_line.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/document_codec.dart';
import 'package:dial_editor/src/feature/editor/util/markdown_render.dart';
import 'package:dial_editor/src/feature/editor/util/string_to_document_converter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class EditPart extends ConsumerStatefulWidget {
  final File file;
  const EditPart({super.key, required this.file});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPartState();
}

class _EditPartState extends ConsumerState<EditPart>
    implements TextSelectionGestureDetectorBuilderDelegate {
  Logger logger = Logger();
  late Document document;
  late String fileString;
  List<Node> nodes = [];
  List<Widget> markdownWidgetList = [];
  final GlobalKey<EditableTextState> _editorKey =
      GlobalKey<EditableTextState>();
  List<double> cumulativeHeights = [];
  ScrollController scrollController1 = ScrollController();
  ScrollController scrollController2 = ScrollController();

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
    bool isScrolling = false;
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isScrolling && scrollInfo.depth == 0) {
          isScrolling = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                scrollController1.jumpTo(scrollController2.offset);
              });
            }
            isScrolling = false;
          });
        }
        return true;
      },
      child: Stack(
        children: [
          Row(
            children: [
              _buildLineNumber(),
              _buildEditingArea(),
            ],
          ),
        ],
      ),
    );
  }

  (List<int>, List<double>) _getVisibleNodeIndices() {
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
    for (int i = 0; i < nodes.length; i++) {
      currentHeight += nodes[i].textHeight;
      if (currentHeight >= scrollStart && currentHeight <= scrollEnd) {
        visibleIndices.add(i);
        cumulativeHeights.add(currentHeight);
      }
      if (currentHeight > scrollEnd) break;
    }
    return (visibleIndices, cumulativeHeights);
  }

  int _getLineIndex(double dy) {
    final (visibleIndices, cumulativeHeights) = _getVisibleNodeIndices();
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

  Widget _buildLineNumber() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: SizedBox(
        width: 30,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView.builder(
            controller: scrollController1,
            itemCount: nodes.length,
            itemBuilder: (context, index) {
              return ValueListenableBuilder<double>(
                valueListenable: nodes[index].textHeightNotifier,
                builder: (context, height, child) {
                  return Row(
                    children: [
                      const Spacer(),
                      Container(
                        alignment: Alignment.centerRight,
                        height: height,
                        child: Text(
                          "${index + 1}",
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEditingArea() {
    return Expanded(
      child: ListView.builder(
        controller: scrollController2,
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
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: nodes[index].controller,
            builder: (context, value, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _updateNodeHeight(index);
              });
              return EditableText(
                key: nodes[index].key,
                controller: nodes[index].controller,
                focusNode: nodes[index].focusNode,
                cursorColor: Colors.blue,
                backgroundCursorColor: Colors.blue,
                style: nodes[index].style,
                showCursor: true,
                selectionColor: Colors.red,
                rendererIgnoresPointer: true,
                enableInteractiveSelection: true,
                paintCursorAboveText: true,
                onChanged: (value) {
                  _onChange(index, value);
                },
                onEditingComplete: () {
                  _onEditingComplete(index);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _updateNodeHeight(int index) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: nodes[index].controller.text,
        style: nodes[index].style,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    final newHeight = textPainter.height;
    if (nodes[index].textHeight != newHeight) {
      setState(() {
        nodes[index].textHeight = newHeight;
      });
    }
  }

  void _onSingleTapUp(int index, TapDragUpDetails details) {
    if (index < 0 || index >= nodes.length) {
      return;
    }
    final node = nodes[index];
    final nodeKey = node.key;
    final EditableTextState? editableTextState = nodeKey.currentState;
    if (editableTextState == null) {
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
    } catch (e) {
      logger.e(e);
    }
  }

  void _onDragSelectionStart(int index, TapDragStartDetails details) {
    final currentNode = nodes[index];
    final RenderEditable renderEditable =
        currentNode.key.currentState!.renderEditable;
    renderEditable.selectPositionAt(
      from: details.globalPosition,
      cause: SelectionChangedCause.drag,
    );
  }

  void _onDragSelectionUpdate(int index, TapDragUpdateDetails details) {
    final mouseIndex = _getLineIndex(details.globalPosition.dy);
    if (mouseIndex == -1 || mouseIndex == index) {
      final renderEditable = nodes[index].key.currentState!.renderEditable;
      renderEditable.selectPositionAt(
        from: details.globalPosition - details.offsetFromOrigin,
        to: details.globalPosition,
        cause: SelectionChangedCause.drag,
      );
      return;
    }
    int lastMouseIndex = -1;
    bool isSelectingUp = false;
    setState(() {
      final bool currentSelectingUp = mouseIndex < index;
      if (lastMouseIndex != -1 && currentSelectingUp != isSelectingUp) {
        for (final node in nodes) {
          node.isEditing = false;
          node.controller.selection = const TextSelection.collapsed(offset: 0);
        }
      }
      isSelectingUp = currentSelectingUp;
      lastMouseIndex = mouseIndex;
      final int startIndex = isSelectingUp ? mouseIndex : index;
      final int endIndex = isSelectingUp ? index : mouseIndex;
      for (int i = startIndex; i <= endIndex; i++) {
        nodes[i].isEditing = true;
        if (i == startIndex) {
          nodes[i].controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: nodes[i].controller.text.length,
          );
        } else if (i == endIndex) {
          nodes[i].controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: isSelectingUp
                ? nodes[i].controller.selection.extentOffset
                : nodes[i].controller.text.length,
          );
        } else {
          nodes[i].controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: nodes[i].controller.text.length,
          );
        }
      }
      for (int i = 0; i < nodes.length; i++) {
        if (i < startIndex || i > endIndex) {
          nodes[i].isEditing = false;
          nodes[i].controller.selection =
              const TextSelection.collapsed(offset: 0);
        }
      }
    });
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
      if (nodes[index] is CodeBlockMarker || nodes[index] is CodeLine) {
        nodes[index] =
            StringToDocumentConverter(context).convertLine(value, true);
      } else {
        nodes[index] =
            StringToDocumentConverter(context).convertLine(value, false);
      }
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
      nodes[index].isEditing = false;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        nodes[index + 1].focusNode.requestFocus();
      });
      _updateDocument();
    });
  }

  void _updateDocument() {
    fileString = document.toString();
    widget.file.writeAsStringSync(fileString);
  }

  Widget _buildRenderingWidget(int index) {
    return GestureDetector(
      onTapUp: (details) {
        setState(() {
          _resetAll();
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
          final int newOffset = nodes[index - 1].rawText.length;
          nodes[index - 1].controller.selection =
              TextSelection.collapsed(offset: newOffset);
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
        final int newOffset = nodes[index - 1].rawText.length;
        nodes[index - 1].controller.selection =
            TextSelection.collapsed(offset: newOffset);
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
        final int newOffset = nodes[index + 1].rawText.length;
        nodes[index + 1].controller.selection =
            TextSelection.collapsed(offset: newOffset);
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
        nodes[index].isEditing = false;
        nodes[index - 1].isEditing = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          nodes[index - 1].focusNode.requestFocus();
        });
      } else if (!isLeft &&
          selection.baseOffset == currentNode.rawText.length &&
          index < nodes.length - 1) {
        nodes[index].isEditing = false;
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
