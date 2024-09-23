import 'dart:io';

import 'package:dial_editor/src/core/provider/ui/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

/// An enumeration representing the different navigation options available
/// within the application. This enum is used to define the various navigation
/// states or destinations that can be navigated to within the app.
enum NavigationEnum {
  /// This widget represents a file navigation component in the application.
  /// It is part of the navigation feature in the UI presentation layer.
  file(
    text: 'File',
    icon: Icon(Icons.adf_scanner_outlined),
    selectedIcon: Icon(Icons.adf_scanner),
  ),

  /// This widget represents a file navigation component in the application.
  /// It is part of the navigation feature in the UI presentation layer.
  search(
    text: 'Search',
    icon: Icon(Icons.person_search_outlined),
    selectedIcon: Icon(Icons.person_search),
  ),

  /// This widget represents a file navigation component in the application.
  /// It is part of the navigation feature in the UI presentation layer.
  setting(
    text: 'Setting',
    icon: Icon(Icons.admin_panel_settings_outlined),
    selectedIcon: Icon(Icons.admin_panel_settings),
  );

  /// A string that holds the text to be displayed or processed.
  final String text;

  /// An icon widget that represents a visual element in the navigation.
  final Icon icon;

  /// The icon that is currently selected and displayed in the navigation
  /// widget.
  final Icon selectedIcon;

  /// Represents the different navigation options available in the application.
  ///
  /// This enum is used to define the various navigation routes or tabs that can
  /// be accessed within the app. Each value in the enum corresponds to a
  /// specific
  /// navigation destination.
  // ignore: sort_constructors_first
  const NavigationEnum({
    required this.text,
    required this.icon,
    required this.selectedIcon,
  });
}

/// A `ConsumerStatefulWidget` that represents the navigation component of the
///  application.
///
/// This widget is responsible for managing the navigation state and rendering
///  the appropriate
/// UI elements based on the current navigation state.
///
/// The `Navigation` widget uses the `ConsumerStatefulWidget` to listen to
/// changes in the
/// application's state and update the UI accordingly.
///
/// Usage:
/// ```dart
/// Navigation();
/// ```
class Navigation extends ConsumerStatefulWidget {
  /// A widget that represents the navigation component.
  ///
  /// This widget is used to navigate between different sections or pages
  /// within the application.
  ///
  /// The [Navigation] widget is typically used in the app's main layout
  /// to provide a consistent navigation experience.
  ///
  /// Example usage:
  /// ```dart
  /// Navigation(
  ///   // Add your parameters here
  /// )
  /// ```
  const Navigation({
    required this.navigationShell,
    super.key,
  });

  /// A final instance of `StatefulNavigationShell` used for managing the state
  /// and navigation within the application.
  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends ConsumerState<Navigation> {
  @override
  Widget build(BuildContext context) {
    void goBranch(int index) {
      widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex,
      );
    }

    return Platform.isWindows || Platform.isMacOS || Platform.isLinux
        ? NavigationNavigation(
            body: widget.navigationShell,
            selectedIndex: widget.navigationShell.currentIndex,
            onDestinationSelected: goBranch,
          )
        : NavigationBottomBar(
            body: widget.navigationShell,
            selectedIndex: widget.navigationShell.currentIndex,
            onDestinationSelected: goBranch,
          );
  }
}

/// A widget that provides navigation functionality within the application.
///
/// This widget is a consumer of the state management system, allowing it to
/// react to changes in the application's state and update the navigation
/// accordingly.
///
/// The `NavigationNavigation` class extends `ConsumerWidget`, which means it
/// can access and listen to providers for state changes.
///
/// Usage:
/// ```dart
/// NavigationNavigation();
/// ```
///
/// This widget should be used in places where navigation is required within
/// the application.
class NavigationNavigation extends ConsumerWidget {
  /// A constant constructor for the `NavigationNavigation` widget.
  ///
  /// This widget is used to handle navigation within the application.
  ///
  /// Example usage:
  /// ```dart
  /// const NavigationNavigation(
  ///   // parameters
  /// );
  /// ```
  const NavigationNavigation({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
    super.key,
  });

  /// The index of the currently selected item.
  final int selectedIndex;

  /// A function that takes an integer as a parameter and returns void.
  final void Function(int) onDestinationSelected;

  /// The body of the navigation widget.
  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationViewModel = ref.read(navigationViewModelProvider.notifier);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            minWidth: 52,
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.none,
            destinations: [
              NavigationRailDestination(
                icon: JustTheTooltip(
                  content: Text(NavigationEnum.file.text),
                  preferredDirection: AxisDirection.right,
                  child: NavigationEnum.file.icon,
                ),
                selectedIcon: JustTheTooltip(
                  content: Text(NavigationEnum.file.text),
                  preferredDirection: AxisDirection.right,
                  child: IconButton(
                    splashRadius: 20,
                    icon: NavigationEnum.file.selectedIcon,
                    onPressed: () {
                      navigationViewModel.openFileSidePanel(ref);
                    },
                  ),
                ),
                label: const Text(''),
              ),
              NavigationRailDestination(
                icon: JustTheTooltip(
                  content: Text(NavigationEnum.search.text),
                  preferredDirection: AxisDirection.right,
                  child: NavigationEnum.search.icon,
                ),
                selectedIcon: JustTheTooltip(
                  content: Text(NavigationEnum.search.text),
                  preferredDirection: AxisDirection.right,
                  child: IconButton(
                    splashRadius: 20,
                    icon: NavigationEnum.search.selectedIcon,
                    onPressed: () {
                      navigationViewModel.openSearchSidePanel(ref);
                    },
                  ),
                ),
                label: const Text(''),
              ),
              NavigationRailDestination(
                icon: JustTheTooltip(
                  content: Text(NavigationEnum.setting.text),
                  preferredDirection: AxisDirection.right,
                  child: NavigationEnum.setting.icon,
                ),
                selectedIcon: JustTheTooltip(
                  content: Text(NavigationEnum.setting.text),
                  preferredDirection: AxisDirection.right,
                  child: IconButton(
                    splashRadius: 20,
                    icon: NavigationEnum.setting.selectedIcon,
                    onPressed: () {
                      navigationViewModel.openSettingSidePanel(ref);
                    },
                  ),
                ),
                label: const Text(''),
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

/// A widget that represents a bottom navigation bar.
///
/// This widget is a consumer widget, which means it listens to changes in the
/// provider and rebuilds accordingly. It is typically used to navigate between
/// different sections of an application.
///
/// Usage:
/// ```dart
/// NavigationBottomBar()
/// ```
///
/// Make sure to wrap this widget with a provider to ensure it functions
/// correctly.
class NavigationBottomBar extends ConsumerWidget {
  /// A widget that represents the bottom navigation bar in the application.
  ///
  /// This widget is used to navigate between different sections of the app.
  /// It is typically placed at the bottom of the screen.
  ///
  /// Usage:
  /// ```dart
  /// NavigationBottomBar(
  ///   // parameters
  /// );
  /// ```
  ///
  /// Parameters:
  /// - Add any parameters here if applicable.
  ///
  /// Example:
  /// ```dart
  /// const NavigationBottomBar(
  ///   // example parameters
  /// );
  /// ```
  const NavigationBottomBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
    super.key,
  });

  /// The index of the currently selected item.
  final int selectedIndex;

  /// A function that takes an integer as a parameter and returns void.
  final void Function(int) onDestinationSelected;

  /// The body of the navigation widget.
  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onDestinationSelected,
        items: [
          BottomNavigationBarItem(
            icon: NavigationEnum.file.icon,
            activeIcon: NavigationEnum.file.selectedIcon,
            label: NavigationEnum.file.text,
          ),
          BottomNavigationBarItem(
            icon: NavigationEnum.search.icon,
            activeIcon: NavigationEnum.search.selectedIcon,
            label: NavigationEnum.search.text,
          ),
          BottomNavigationBarItem(
            icon: NavigationEnum.setting.icon,
            activeIcon: NavigationEnum.setting.icon,
            label: NavigationEnum.setting.text,
          ),
        ],
      ),
    );
  }
}
