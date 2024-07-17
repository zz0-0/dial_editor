import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class InfoCard extends Equatable {
  const InfoCard({
    required this.key,
    required this.position,
    required this.height,
    required this.width,
    required this.inputNode,
    required this.outputNode,
  });

  final GlobalKey key;
  final Offset position;
  final double height;
  final double width;
  final GlobalKey inputNode;
  final GlobalKey outputNode;

  InfoCard copyWith({
    GlobalKey? key,
    Offset? position,
    double? height,
    double? width,
    GlobalKey? inputNode,
    GlobalKey? outputNode,
  }) {
    return InfoCard(
      key: key ?? this.key,
      position: position ?? this.position,
      height: height ?? this.height,
      width: width ?? this.width,
      inputNode: inputNode ?? this.inputNode,
      outputNode: outputNode ?? this.outputNode,
    );
  }

  @override
  List<Object?> get props =>
      [key, position, height, width, inputNode, outputNode];
}

class InfoCardNotifier extends StateNotifier<InfoCard> {
  InfoCardNotifier(super.state);

  void updatePosition(Offset offset) {
    state = state.copyWith(position: offset);
  }
}
