import 'dart:io';

import 'package:dial_editor/src/core/provider/ui/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

enum NavigationEnum {
  file(
    text: "File",
    icon: Icon(Icons.adf_scanner_outlined),
    selectedIcon: Icon(Icons.adf_scanner),
  ),
  search(
    text: "Search",
    icon: Icon(Icons.person_search_outlined),
    selectedIcon: Icon(Icons.person_search),
  ),
  setting(
    text: "Setting",
    icon: Icon(Icons.admin_panel_settings_outlined),
    selectedIcon: Icon(Icons.admin_panel_settings),
  );

  final String text;
  final Icon icon;
  final Icon selectedIcon;
  const NavigationEnum({
    required this.text,
    required this.icon,
    required this.selectedIcon,
  });
}

class Navigation extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const Navigation({
    super.key,
    required this.navigationShell,
  });

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

class NavigationNavigation extends ConsumerWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final Widget body;

  const NavigationNavigation({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
  });

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

class NavigationBottomBar extends ConsumerWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final Widget body;

  const NavigationBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
  });

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
