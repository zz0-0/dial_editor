import 'dart:io';
import 'package:dial_editor/src/feature/core/presentation/widget/sidepanel/side_panel_provider.dart';
import 'package:dial_editor/src/feature/core/presentation/widget/topbar/top_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

enum Navigation {
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
  const Navigation({
    required this.text,
    required this.icon,
    required this.selectedIcon,
  });
}

class Sidebar extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const Sidebar({
    super.key,
    required this.navigationShell,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SidebarState();
}

class _SidebarState extends ConsumerState<Sidebar> {
  @override
  Widget build(BuildContext context) {
    void goBranch(int index) {
      widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex,
      );
    }

    return Platform.isWindows || Platform.isMacOS || Platform.isLinux
        ? NavigationSideBar(
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

class NavigationSideBar extends ConsumerWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final Widget body;

  const NavigationSideBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  content: Text(Navigation.file.text),
                  preferredDirection: AxisDirection.right,
                  child: Navigation.file.icon,
                ),
                selectedIcon: JustTheTooltip(
                  content: Text(Navigation.file.text),
                  preferredDirection: AxisDirection.right,
                  child: IconButton(
                    icon: Navigation.file.selectedIcon,
                    onPressed: () {
                      _openFileSidePanel(ref);
                    },
                  ),
                ),
                label: const Text(''),
              ),
              NavigationRailDestination(
                icon: JustTheTooltip(
                  content: Text(Navigation.search.text),
                  preferredDirection: AxisDirection.right,
                  child: Navigation.search.icon,
                ),
                selectedIcon: JustTheTooltip(
                  content: Text(Navigation.search.text),
                  preferredDirection: AxisDirection.right,
                  child: IconButton(
                    icon: Navigation.search.selectedIcon,
                    onPressed: () {
                      _openSearchSidePanel(ref);
                    },
                  ),
                ),
                label: const Text(''),
              ),
              NavigationRailDestination(
                icon: JustTheTooltip(
                  content: Text(Navigation.setting.text),
                  preferredDirection: AxisDirection.right,
                  child: Navigation.setting.icon,
                ),
                selectedIcon: JustTheTooltip(
                  content: Text(Navigation.setting.text),
                  preferredDirection: AxisDirection.right,
                  child: IconButton(
                    icon: Navigation.setting.selectedIcon,
                    onPressed: () {
                      _openSettingSidePanel(ref);
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

  void _openFileSidePanel(WidgetRef ref) {
    if (ref.read(openFolderProvider)) {
      ref.read(fileSidePanelProvider.notifier).update(
            (state) => !ref.read(fileSidePanelProvider),
          );
    } else {
      ref.read(fileEmptySidePanelProvider.notifier).update(
            (state) => !ref.read(fileEmptySidePanelProvider),
          );
    }
  }

  void _openSearchSidePanel(WidgetRef ref) {
    ref.read(searchSidePanelProvider.notifier).update(
          (state) => !ref.read(searchSidePanelProvider),
        );
  }

  void _openSettingSidePanel(WidgetRef ref) {
    ref.read(settingSidePanelProvider.notifier).update(
          (state) => !ref.read(settingSidePanelProvider),
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
            icon: Navigation.file.icon,
            activeIcon: Navigation.file.selectedIcon,
            label: Navigation.file.text,
          ),
          BottomNavigationBarItem(
            icon: Navigation.search.icon,
            activeIcon: Navigation.search.selectedIcon,
            label: Navigation.search.text,
          ),
          BottomNavigationBarItem(
            icon: Navigation.setting.icon,
            activeIcon: Navigation.setting.icon,
            label: Navigation.setting.text,
          ),
        ],
      ),
    );
  }
}
