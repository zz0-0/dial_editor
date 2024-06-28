// import 'package:dial_editor/main.dart';
import 'package:dial_editor/src/feature/core/presentation/screen/branch/file_branch.dart';
import 'package:dial_editor/src/feature/core/presentation/screen/branch/setting_branch.dart';
import 'package:dial_editor/src/feature/core/presentation/widget/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  initialLocation: "/file",
  navigatorKey: _rootNavigatorKey,
  routes: [
    // GoRoute(
    //   path: '/',
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       key: state.pageKey,
    //       child: const DesktopEditor(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity:
    //               CurveTween(curve: Curves.easeInOutCirc).animate(animation),
    //           child: child,
    //         );
    //       },
    //     );
    //   },
    // ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return Sidebar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/file',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const FileBranch(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/setting',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const SettingBranch(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
