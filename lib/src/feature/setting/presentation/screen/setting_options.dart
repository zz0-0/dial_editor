import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

enum SettingNavigation {
  appearance(
    text: "Appearance",
    icon: Icon(Icons.auto_awesome_outlined),
    selectedIcon: Icon(Icons.auto_awesome),
  ),
  keyboard(
    text: "Keyboard",
    icon: Icon(Icons.keyboard_outlined),
    selectedIcon: Icon(Icons.keyboard),
  );
  // setting(
  //   text: "Setting",
  //   // icon: Icon(Icons.admin_panel_settings_outlined),
  //   // selectedIcon: Icon(Icons.admin_panel_settings),
  // );

  final String text;
  final Icon icon;
  final Icon selectedIcon;
  const SettingNavigation({
    required this.text,
    required this.icon,
    required this.selectedIcon,
  });
}

class SettingOptions extends ConsumerStatefulWidget {
  final StatefulNavigationShell? navigationShell;
  const SettingOptions({
    super.key,
    required this.navigationShell,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingOptionsState();
}

class _SettingOptionsState extends ConsumerState<SettingOptions> {
  @override
  Widget build(BuildContext context) {
    void goBranch(int index) {
      widget.navigationShell!.goBranch(
        index,
        initialLocation: index == widget.navigationShell!.currentIndex,
      );
    }

    return SettingNavigationSideBar(
      body: widget.navigationShell!,
      selectedIndex: widget.navigationShell!.currentIndex,
      onDestinationSelected: goBranch,
    );
  }
}

class SettingNavigationSideBar extends ConsumerWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final Widget body;

  const SettingNavigationSideBar({
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
            extended: true,
            minExtendedWidth: 200,
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: [
              NavigationRailDestination(
                icon: JustTheTooltip(
                  content: Text(SettingNavigation.appearance.text),
                  preferredDirection: AxisDirection.right,
                  child: SettingNavigation.appearance.icon,
                ),
                selectedIcon: JustTheTooltip(
                  content: Text(SettingNavigation.appearance.text),
                  preferredDirection: AxisDirection.right,
                  child: IconButton(
                    icon: SettingNavigation.appearance.selectedIcon,
                    onPressed: () {},
                  ),
                ),
                label: Text(SettingNavigation.appearance.text),
              ),
              NavigationRailDestination(
                icon: JustTheTooltip(
                  content: Text(SettingNavigation.keyboard.text),
                  preferredDirection: AxisDirection.right,
                  child: SettingNavigation.keyboard.icon,
                ),
                selectedIcon: JustTheTooltip(
                  content: Text(SettingNavigation.keyboard.text),
                  preferredDirection: AxisDirection.right,
                  child: IconButton(
                    icon: SettingNavigation.keyboard.selectedIcon,
                    onPressed: () {},
                  ),
                ),
                label: Text(SettingNavigation.keyboard.text),
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
