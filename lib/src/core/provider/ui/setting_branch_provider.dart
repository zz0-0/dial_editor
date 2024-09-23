import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A [StateProvider] that manages the state of the setting side panel.
/// 
/// This provider holds a boolean value indicating whether the setting side 
/// panel
/// is open or closed. The initial state is set to `false`, meaning the panel 
/// is closed.
/// 
/// Usage:
/// ```dart
/// final isPanelOpen = ref.watch(settingSidePanelProvider);
/// final togglePanel = ref.read(settingSidePanelProvider.notifier).state = 
/// !isPanelOpen;
/// ```
/// 
/// This provider can be used to control the visibility of the setting side 
/// panel
/// in the UI.
final settingSidePanelProvider = StateProvider((ref) => false);
