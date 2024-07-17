import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class Group extends Equatable {
  const Group({
    required this.key,
    required this.position,
    required this.cards,
  });

  final GlobalKey key;
  final Offset position;
  final Set<GlobalKey> cards;

  Group copyWith({GlobalKey? key, Offset? position, Set<GlobalKey>? cards}) {
    return Group(
      key: key ?? this.key,
      position: position ?? this.position,
      cards: cards ?? this.cards,
    );
  }

  @override
  List<Object?> get props => [key, position, cards];
}

class GroupNotifier extends StateNotifier<Group> {
  GroupNotifier(super.state);

  void updatePosition(Offset offset) {
    state = state.copyWith(position: offset);
  }

  void addCard(GlobalKey key) {
    final Set<GlobalKey> newCards = Set.from(state.cards);
    newCards.add(key);
    state = state.copyWith(cards: newCards);
  }

  void removeCard(GlobalKey key) {
    final Set<GlobalKey> newCards = Set.from(state.cards);
    newCards.remove(key);
    state = state.copyWith(cards: newCards);
  }
}
