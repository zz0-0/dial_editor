import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

/// An enumeration representing the various settings available in the
/// application.
///
/// This enum is used to define the different settings that can be configured
/// within the application. Each value in the enum corresponds to a specific
/// setting option.
enum SettingEnum {
  /// This function handles the appearance settings for the application.
  /// It allows customization of the visual aspects of the user interface,
  /// such as themes, colors, and other stylistic elements.
  appearance(
    text: 'Appearance',
    icon: Icon(Icons.auto_awesome_outlined),
    selectedIcon: Icon(Icons.auto_awesome),
  ),

  /// A widget that represents a keyboard setting in the application.
  ///
  /// This widget is used to configure and display keyboard-related settings
  /// within the application. It provides various options and controls to
  /// customize the keyboard behavior and appearance.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// keyboard(
  ///   // configuration options
  /// );
  /// ```
  ///
  /// Make sure to pass the appropriate configuration options to customize
  /// the keyboard settings as per your requirements.
  keyboard(
    text: 'Keyboard',
    icon: Icon(Icons.keyboard_outlined),
    selectedIcon: Icon(Icons.keyboard),
  );

  /// A string that holds the text to be displayed or processed.
  final String text;

  /// An icon widget that represents a visual element in the settings.
  ///
  /// This icon is used to display a graphical representation within the
  /// settings widget, providing a visual cue for the user.
  final Icon icon;

  /// The icon that is currently selected and displayed in the settings widget.
  final Icon selectedIcon;

  /// A constant constructor for the `SettingEnum` class.
  ///
  /// This constructor is used to create instances of the `SettingEnum` class.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// const mySetting = SettingEnum();
  /// ```
  ///
  /// Note: Replace `SettingEnum` with the actual enum name if different.
  // ignore: sort_constructors_first
  const SettingEnum({
    required this.text,
    required this.icon,
    required this.selectedIcon,
  });
}

/// A `ConsumerStatefulWidget` that represents the settings screen in the
/// application.
///
/// This widget is responsible for displaying and managing the settings options
/// available to the user. It utilizes the `ConsumerStatefulWidget` to listen to
/// changes in the state and update the UI accordingly.
///
/// The `Setting` widget is part of the presentation layer of the settings
/// feature.
///
/// Usage:
/// ```dart
/// Setting();
/// ```
class Setting extends ConsumerStatefulWidget {
  /// A constant constructor for the `Setting` widget.
  ///
  /// This constructor initializes a new instance of the `Setting` widget.
  const Setting({
    required this.navigationShell,
    super.key,
  });

  /// A nullable instance of [StatefulNavigationShell] used for managing
  /// navigation state within the settings feature.
  ///
  /// This allows the settings widget to interact with and control the
  /// navigation shell, enabling dynamic updates and state management
  /// based on user interactions or other events.
  final StatefulNavigationShell? navigationShell;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingState();
}

class _SettingState extends ConsumerState<Setting> {
  @override
  Widget build(BuildContext context) {
    void goBranch(int index) {
      widget.navigationShell!.goBranch(
        index,
        initialLocation: index == widget.navigationShell!.currentIndex,
      );
    }

    return SettingEnumSideBar(
      body: widget.navigationShell!,
      selectedIndex: widget.navigationShell!.currentIndex,
      onDestinationSelected: goBranch,
    );
  }
}

/// A widget that represents the sidebar for settings in the application.
///
/// This widget is a consumer widget, which means it listens to changes in the
/// provider and rebuilds accordingly. It is used to display various settings
/// options in a sidebar format.
///
/// The `SettingEnumSideBar` class extends `ConsumerWidget`, which is part of
/// the Riverpod package, allowing it to react to changes in the state of the
/// application.
///
/// Usage:
/// ```dart
/// SettingEnumSideBar()
/// ```
///
/// This widget should be used within the context of a Riverpod provider to
/// ensure it can listen to and react to state changes.
class SettingEnumSideBar extends ConsumerWidget {
  /// A constant constructor for the `SettingEnumSideBar` widget.
  ///
  /// This widget is used to represent the sidebar settings in the application.
  const SettingEnumSideBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
    super.key,
  });

  /// The index of the currently selected item.
  ///
  /// This is used to keep track of which item is selected in a list or a menu.
  ///
  /// Example:
  /// ```dart
  /// int currentIndex = selectedIndex;
  /// ```
  final int selectedIndex;

  /// Callback function that is triggered when a destination is selected.
  ///
  /// The function takes an integer parameter which represents the index of the
  /// selected destination.
  ///
  /// Example usage:
  /// ```dart
  /// onDestinationSelected: (index) {
  ///   // Handle the destination selection
  ///   print('Selected destination index: $index');
  /// },
  /// ```
  final void Function(int) onDestinationSelected;

  /// A widget that represents the body of the settings screen.
  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            minExtendedWidth: 200,
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: [
              NavigationRailDestination(
                icon: JustTheTooltip(
                  content: Text(SettingEnum.appearance.text),
                  preferredDirection: AxisDirection.right,
                  child: SettingEnum.appearance.icon,
                ),
                selectedIcon: JustTheTooltip(
                  content: Text(SettingEnum.appearance.text),
                  preferredDirection: AxisDirection.right,
                  child: IconButton(
                    splashRadius: 20,
                    icon: SettingEnum.appearance.selectedIcon,
                    onPressed: () {},
                  ),
                ),
                label: Text(SettingEnum.appearance.text),
              ),
              NavigationRailDestination(
                icon: JustTheTooltip(
                  content: Text(SettingEnum.keyboard.text),
                  preferredDirection: AxisDirection.right,
                  child: SettingEnum.keyboard.icon,
                ),
                selectedIcon: JustTheTooltip(
                  content: Text(SettingEnum.keyboard.text),
                  preferredDirection: AxisDirection.right,
                  child: IconButton(
                    splashRadius: 20,
                    icon: SettingEnum.keyboard.selectedIcon,
                    onPressed: () {},
                  ),
                ),
                label: Text(SettingEnum.keyboard.text),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
