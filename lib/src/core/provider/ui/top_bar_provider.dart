import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A [StateProvider] that manages the state of whether a folder is open or not.
///
/// This provider holds a boolean value, where `true` indicates that the folder
/// is open, and `false` indicates that the folder is closed.
///
/// Usage:
///
/// ```dart
/// final isOpen = ref.watch(openFolderProvider).state;
/// ```
///
/// The initial state is set to `false`.
final openFolderProvider = StateProvider<bool>((ref) => false);
