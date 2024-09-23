import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider that manages the state of the file side panel's visibility.
///
/// This provider uses a [StateProvider] to hold a boolean value indicating
/// whether the file side panel is visible (`true`) or hidden (`false`).
///
/// Usage:
/// ```dart
/// final isVisible = ref.watch(fileSidePanelProvider).state;
/// ref.read(fileSidePanelProvider).state = true; // Show the panel
/// ref.read(fileSidePanelProvider).state = false; // Hide the panel
/// ```
final fileSidePanelProvider = StateProvider((ref) => false);

/// A [StateProvider] that manages the state of whether the side panel is empty
/// or not.
///
/// This provider holds a boolean value:
/// - `true` indicates that the side panel is empty.
/// - `false` indicates that the side panel is not empty.
///
/// Usage:
/// ```dart
/// final isEmpty = ref.watch(fileEmptySidePanelProvider).state;
/// ```
final fileEmptySidePanelProvider = StateProvider((ref) => false);

/// A state provider for managing the state of a file.
///
/// This provider holds a nullable [File] object, which can be used to
/// represent the current file being worked on or selected in the UI.
///
/// The initial state of the provider is `null`.
///
/// Usage:
/// ```dart
/// final file = ref.watch(fileProvider).state;
/// ```
final fileProvider = StateProvider<File?>((ref) => null);
