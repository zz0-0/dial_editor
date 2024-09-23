import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A [StateProvider] that manages the visibility state of the search side 
/// panel.
/// 
/// This provider holds a boolean value indicating whether the search side panel
/// is visible (`true`) or hidden (`false`). The default state is hidden 
/// (`false`).
///
/// Usage:
/// ```dart
/// final isVisible = ref.watch(searchSidePanelProvider);
/// ```
final searchSidePanelProvider = StateProvider((ref) => false);
