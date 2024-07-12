import 'package:dial_editor/src/feature/core/presentation/screen/branch/file_branch.dart';
import 'package:dial_editor/src/feature/core/presentation/screen/branch/search_branch.dart';
import 'package:dial_editor/src/feature/core/presentation/screen/branch/setting_branch.dart';
import 'package:dial_editor/src/feature/core/presentation/widget/sidebar/sidebar.dart';
import 'package:dial_editor/src/feature/setting/presentation/screen/setting_options.dart';
import 'package:dial_editor/src/feature/setting/presentation/widget/appearance_setting.dart';
import 'package:dial_editor/src/feature/setting/presentation/widget/keyboard_setting.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  initialLocation: "/file",
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell1) {
        return Sidebar(navigationShell: navigationShell1);
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
              routes: [
                StatefulShellRoute.indexedStack(
                  builder: (context2, state2, navigationShell2) {
                    return SettingOptions(
                      navigationShell: navigationShell2,
                    );
                  },
                  branches: [
                    StatefulShellBranch(
                      routes: [
                        GoRoute(
                          path: "appearance",
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
                                  opacity:
                                      CurveTween(curve: Curves.easeInOutCirc)
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
                          path: "keyboard",
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
                                  opacity:
                                      CurveTween(curve: Curves.easeInOutCirc)
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
    ),
  ],
);
