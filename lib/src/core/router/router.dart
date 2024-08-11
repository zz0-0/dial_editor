import 'package:dial_editor/src/feature/setting/presentation/widget/appearance_setting.dart';
import 'package:dial_editor/src/feature/setting/presentation/widget/keyboard_setting.dart';
import 'package:dial_editor/src/feature/setting/presentation/widget/setting.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/navigation/branch/file_branch.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/navigation/branch/search_branch.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  initialLocation: "/file",
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell1) {
        return Navigation(navigationShell: navigationShell1);
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
              path: '/search',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const SearchBranch(),
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
            StatefulShellRoute.indexedStack(
              builder: (context2, state2, navigationShell2) {
                return Setting(
                  navigationShell: navigationShell2,
                );
              },
              branches: [
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: "/appearance",
                      pageBuilder: (context, state) {
                        return CustomTransitionPage(
                          key: state.pageKey,
                          child: const AppearanceSetting(),
                          transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) {
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
                      path: "/keyboard",
                      pageBuilder: (context, state) {
                        return CustomTransitionPage(
                          key: state.pageKey,
                          child: const KeyboardSetting(),
                          transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) {
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
        ),
      ],
    ),
  ],
);
