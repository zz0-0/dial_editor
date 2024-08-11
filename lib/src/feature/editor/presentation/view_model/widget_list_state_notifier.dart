import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetListStateNotifier extends StateNotifier<List<Widget>> {
  Ref ref;

  WidgetListStateNotifier(this.ref) : super([]);

  List<Widget> getList() {
    return state;
  }

  int getListLength() {
    return state.length;
  }

  void updateList(List<Inline> list) {
    final renderAdapter = ref.read(renderAdapterProvider);
    final widgetList = list.map((node) {
      final instruction = node.render();
      return renderAdapter.adapt(node, instruction);
    }).toList();
    state = widgetList;
  }

  Widget getWidgetByIndex(int index) {
    return state[index];
  }

  void updateWidgetByIndex(int index, Widget widget) {
    final List<Widget> list = [...state];
    list[index] = widget;
    state = list;
  }

  void removeWidgetByIndex(int index) {
    final List<Widget> list = [...state];
    list.removeAt(index);
    state = list;
  }

  void insertWidgetByIndex(int i, Widget widget) {
    final List<Widget> list = [...state];
    list.insert(i, widget);
    state = list;
  }

  void addWidget(Widget widget) {
    final List<Widget> list = [...state];
    list.add(widget);
    state = list;
  }
}
