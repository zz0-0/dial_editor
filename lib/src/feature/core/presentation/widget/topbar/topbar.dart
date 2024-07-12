import 'package:dial_editor/src/feature/core/presentation/theme/theme_provider.dart';
import 'package:dial_editor/src/feature/core/presentation/widget/sidepanel/side_panel_provider.dart';
import 'package:dial_editor/src/feature/core/presentation/widget/topbar/top_bar_provider.dart';
import 'package:dial_editor/src/feature/file_management/directory/file_directory/domain/model/directory_node_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Topbar extends ConsumerStatefulWidget {
  const Topbar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopbarState();
}

class _TopbarState extends ConsumerState<Topbar> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = ref.watch(themeNotifierProvider);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: MenuBar(
            children: <Widget>[
              SubmenuButton(
                menuChildren: <Widget>[
                  MenuItemButton(
                    onPressed: () async {
                      ref.read(directoryNodeListProvider.notifier).openFolder;
                      ref
                          .read(openFolderProvider.notifier)
                          .update((state) => true);
                      ref
                          .read(fileSidePanelProvider.notifier)
                          .update((state) => true);
                    },
                    child: const MenuAcceleratorLabel('&Open Folder'),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      themeNotifier.switchThemeMode();
                    },
                    child: const MenuAcceleratorLabel('&Switch Theme'),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Saved!'),
                        ),
                      );
                    },
                    child: const MenuAcceleratorLabel('&Save'),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Quit!'),
                        ),
                      );
                    },
                    child: const MenuAcceleratorLabel('&Quit'),
                  ),
                ],
                child: const MenuAcceleratorLabel('&File'),
              ),
              SubmenuButton(
                menuChildren: <Widget>[
                  MenuItemButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Magnify!'),
                        ),
                      );
                    },
                    child: const MenuAcceleratorLabel('&Magnify'),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Minify!'),
                        ),
                      );
                    },
                    child: const MenuAcceleratorLabel('Mi&nify'),
                  ),
                ],
                child: const MenuAcceleratorLabel('&View'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
