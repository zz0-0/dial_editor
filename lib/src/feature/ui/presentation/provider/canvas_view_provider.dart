// default
import 'package:dial_editor/src/feature/editor/domain/model/canvas/edge.dart';
import 'package:dial_editor/src/feature/editor/domain/model/canvas/group.dart';
import 'package:dial_editor/src/feature/editor/domain/model/canvas/info_card.dart';
import 'package:dial_editor/src/feature/editor/domain/model/canvas/node.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/group_widget.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuLeftPositionProvider = StateProvider<double>((ref) => 10);
final menuBottomPositionProvider = StateProvider<double>((ref) => 10);
final canvasHeightProvider = StateProvider<double>((ref) => 1000.0);
final canvasWidthProvider = StateProvider<double>((ref) => 1000.0);
final divisionsProvider = StateProvider<int>((ref) => 2);
final subdivisionsProvider = StateProvider<int>((ref) => 2);

// resize
final cardHeightProvider =
    StateProvider.family<double, GlobalKey>((ref, key) => 200);
final cardWidthProvider =
    StateProvider.family<double, GlobalKey>((ref, id) => 200);
final groupHeightProvider =
    StateProvider.family<double, GlobalKey>((ref, key) => 600);
final groupWidthProvider =
    StateProvider.family<double, GlobalKey>((ref, id) => 600);

// paint
final startKeyProvider = StateProvider<GlobalKey?>((ref) => null);
final endKeyProvider = StateProvider<GlobalKey?>((ref) => null);
final notSetStartNodeProvider = StateProvider<bool>((ref) => true);
final connectedNodeListProvider = StateProvider<Set<Edge>>((ref) => <Edge>{});
final mouseXProvider = StateProvider((ref) => 0.0);
final mouseYProvider = StateProvider((ref) => 0.0);
final nodeProvider =
    StateNotifierProvider.family<NodeNotifier, Node, GlobalKey>((ref, key) {
  return NodeNotifier(Node(key: key, position: Offset.infinite));
});

// drag and drop
final cardLayoutProvider =
    StateNotifierProvider<LayoutIdNotifier, List<LayoutId>>(
  (ref) => LayoutIdNotifier(),
);
final cardProvider =
    StateNotifierProvider.family<InfoCardNotifier, InfoCard, GlobalKey>(
        (ref, key) {
  final key1 = GlobalKey();
  final key2 = GlobalKey();
  return InfoCardNotifier(
    InfoCard(
      key: key,
      position: Offset.infinite,
      height: 0,
      width: 0,
      inputNode: key1,
      outputNode: key2,
    ),
  );
});

final groupLayoutProvider =
    StateNotifierProvider<LayoutIdNotifier, List<LayoutId>>(
  (ref) => LayoutIdNotifier(),
);
final groupProvider =
    StateNotifierProvider.family<GroupNotifier, Group, GlobalKey>((ref, key) {
  return GroupNotifier(
    Group(
      key: key,
      position: Offset.infinite,
      cards: const <GlobalKey>{},
    ),
  );
});

// scale
final scaleProvider = StateProvider((ref) => 1.0);
final transformationControllerProvider = Provider((ref) {
  final scale = ref.watch(scaleProvider);
  final TransformationController transformationController =
      TransformationController();
  transformationController.value.scale(scale);
  return transformationController;
});

// detail card info
final cardTypeProvider =
    StateProvider.family<CardType, GlobalKey>((ref, id) => CardType.simple);

// card border
final cardSelectedProvider =
    StateProvider.family<bool, GlobalKey>((ref, key) => false);

class LayoutIdNotifier extends StateNotifier<List<LayoutId>> {
  LayoutIdNotifier() : super([]);

  void addLayoutId(LayoutId layoutId) {
    state = [...state, layoutId];
  }

  void removeLayoutId(GlobalKey key) {
    state = [
      for (final layoutid in state)
        if (layoutid.key != key) layoutid,
    ];
  }

  LayoutId build(GlobalKey key, ResizeType type) {
    return LayoutId(
      id: key,
      child: type == ResizeType.group
          ? GroupWidget(
              groupKey: key,
            )
          : InfoCardWidget(
              cardKey: key,
            ),
    );
  }
}

enum ResizeDirection {
  left("LEFT"),
  bottom("BOTTOM"),
  right("RIGHT"),
  bottomRight("BOTTOMRIGHT");

  const ResizeDirection(this.label);
  final String label;
}

enum ResizeType {
  card("CARD"),
  group("GROUP");

  const ResizeType(this.label);
  final String label;
}

enum CardType {
  simple("Simple"),
  complex("Complex");

  const CardType(this.label);
  final String label;
}
