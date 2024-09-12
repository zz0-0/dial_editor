import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

enum SettingEnum {
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

  final String text;
  final Icon icon;
  final Icon selectedIcon;
  const SettingEnum({
    required this.text,
    required this.icon,
    required this.selectedIcon,
  });
}

class Setting extends ConsumerStatefulWidget {
  final StatefulNavigationShell? navigationShell;
  const Setting({
    super.key,
    required this.navigationShell,
  });

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

class SettingEnumSideBar extends ConsumerWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final Widget body;

  const SettingEnumSideBar({
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
