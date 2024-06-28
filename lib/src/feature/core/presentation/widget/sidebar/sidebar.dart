import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

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
            destinations: const [
              NavigationRailDestination(
                icon: JustTheTooltip(
                  content: Text("File"),
                  preferredDirection: AxisDirection.right,
                  child: Icon(Icons.favorite_border),
                ),
                selectedIcon: JustTheTooltip(
                  content: Text("File"),
                  preferredDirection: AxisDirection.right,
                  child: Icon(Icons.favorite),
                ),
                label: Text(''),
              ),
              NavigationRailDestination(
                icon: JustTheTooltip(
                  content: Text("Setting"),
                  preferredDirection: AxisDirection.right,
                  child: Icon(Icons.star_border),
                ),
                selectedIcon: JustTheTooltip(
                  content: Text("Setting"),
                  preferredDirection: AxisDirection.right,
                  child: Icon(Icons.star),
                ),
                label: Text(''),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'File',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            activeIcon: Icon(Icons.star),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
