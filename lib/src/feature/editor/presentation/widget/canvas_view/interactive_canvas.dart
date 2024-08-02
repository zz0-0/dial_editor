import 'package:dial_editor/src/feature/editor/domain/model/canvas/group.dart';
import 'package:dial_editor/src/feature/editor/domain/model/canvas/info_card.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/background.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/canvas_view/edge_widget.dart';
import 'package:dial_editor/src/feature/ui/presentation/provider/canvas_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InteractiveCanvas extends ConsumerStatefulWidget {
  const InteractiveCanvas({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InteractiveCanvasState();
}

class _InteractiveCanvasState extends ConsumerState<InteractiveCanvas> {
  @override
  Widget build(BuildContext context) {
    final canvasWidth = ref.watch(canvasWidthProvider);
    final canvasHeight = ref.watch(canvasHeightProvider);

    return MouseRegion(
      onHover: updateMouseLocation,
      child: InteractiveViewer(
        transformationController: ref.watch(transformationControllerProvider),
        clipBehavior: Clip.antiAlias,
        constrained: false,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: removeSelectedCardBorder,
          child: SizedBox(
            width: 2 * canvasWidth,
            height: 2 * canvasHeight,
            child: Stack(
              children: [
                const Background(),
                const EdgeWidget(),
                // seperate consumer for reducing times to rebuild
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    // update provider after build, in the build would cause error
                    executeAfterLayout();
                    return CustomMultiChildLayout(
                      delegate: LayoutDelegate(ref),
                      children: [
                        ...ref.watch(groupLayoutProvider),
                        ...ref.watch(cardLayoutProvider),
                      ],
                    );
                  },
                ),
                // Consumer(builder:
                //     (BuildContext context, WidgetRef ref, Widget? child) {
                //   return const EdgeWidget();
                // }),
                // Consumer(
                //   builder: (BuildContext context, WidgetRef ref, Widget? child) {

                //     return CustomPaint(painter: EdgePainter(ref));
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateMouseLocation(PointerEvent details) {
    ref
        .read(mouseXProvider.notifier)
        .update((state) => state = details.position.dx);
    ref
        .read(mouseYProvider.notifier)
        .update((state) => state = details.position.dy);
  }

  Future<void> executeAfterLayout() async {
    await Future.delayed(Duration.zero);
    // save the location of the group
    if (groupClone != null) {
      if (groupClone!.position != Offset.infinite) {
        if (ref.watch(groupProvider(groupClone!.key)) != groupClone) {
          ref
              .read(groupProvider(groupClone!.key).notifier)
              .updatePosition(groupClone!.position);
        }
      }
    }
    groupClone = null;

    // save the position of the card
    if (cardClone != null) {
      if (cardClone!.position != Offset.infinite) {
        if (ref.watch(cardProvider(cardClone!.key)) != cardClone) {
          ref
              .read(cardProvider(cardClone!.key).notifier)
              .updatePosition(cardClone!.position);
          final card = ref.watch(cardProvider(cardClone!.key));
          ref
              .read(nodeProvider(card.inputNode).notifier)
              .updatePosition(cardClone!.position + const Offset(0, 100));
          ref
              .read(nodeProvider(card.outputNode).notifier)
              .updatePosition(cardClone!.position + const Offset(200, 100));
        }
      }
    }
    cardClone = null;
  }

  void removeSelectedCardBorder() {
    final cardLayout = ref.watch(cardLayoutProvider);
    for (final layoutId in cardLayout) {
      final key = layoutId.id;
      final card = ref.watch(cardProvider(key as GlobalKey));
      if (ref.watch(cardSelectedProvider(card.key)) == true) {
        ref
            .watch(cardSelectedProvider(card.key).notifier)
            .update((state) => false);
      }
    }
  }
}

InfoCard? cardClone;
Group? groupClone;

class LayoutDelegate extends MultiChildLayoutDelegate {
  WidgetRef ref;
  LayoutDelegate(this.ref);
  Offset cardChildPosition = Offset.zero;
  Offset groupChildPosition = const Offset(250, 0);

  @override
  void performLayout(Size size) {
    // obtain all keys based on groupLayoutProvider
    final groupLayout = ref.watch(groupLayoutProvider);
    for (final layoutId in groupLayout) {
      final key = layoutId.id;
      final group = ref.watch(groupProvider(key as GlobalKey));
      final position = group.position;
      if (hasChild(key)) {
        final Size currentSize = layoutChild(
          key,
          BoxConstraints(maxWidth: size.width, maxHeight: size.height),
        );
        if (position != Offset.infinite) {
          // the existing layout is based on the saved location,
          // mainly to deal with the situation after dragging and dropping
          positionChild(key, position);
        } else {
          // add new cards, layout according to default positions,
          // and for each new card added, the default value increases
          positionChild(key, groupChildPosition);
          groupClone = group.copyWith(position: groupChildPosition);
          groupChildPosition += Offset(0, currentSize.height + 5);
        }
      }
    }

    final cardLayout = ref.watch(cardLayoutProvider);
    for (final layoutId in cardLayout) {
      final key = layoutId.id;
      final card = ref.watch(cardProvider(key as GlobalKey));
      final position = card.position;
      if (hasChild(key)) {
        final Size currentSize = layoutChild(
          key,
          BoxConstraints(maxWidth: size.width, maxHeight: size.height),
        );
        if (position != Offset.infinite) {
          positionChild(key, position);
        } else {
          positionChild(key, cardChildPosition);
          cardClone = card.copyWith(position: cardChildPosition);
          cardChildPosition += Offset(0, currentSize.height + 5);
        }
      }
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => true;
}
