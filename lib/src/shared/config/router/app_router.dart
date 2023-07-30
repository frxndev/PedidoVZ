
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pedidosvz/src/shared/presentation/layout/app_scaffold.dart';
import 'package:pedidosvz/src/shared/presentation/screens/screens.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final Provider<GoRouter> appRouterProvider = Provider<GoRouter>(
  (ProviderRef<GoRouter> ref) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/',
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return AppScaffold(child: navigationShell);
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(routes: <RouteBase>[
              GoRoute(
                path: '/',
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: const HomePage(),
                    key: state.pageKey,
                  );
                },
              ),
              GoRoute(
                path: '/orders',
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: const OrdersPage(),
                    key: state.pageKey,
                  );
                },
              ),
              GoRoute(
                path: '/about',
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: const AboutPage(),
                    key: state.pageKey,
                  );
                },
              )
            ]),
          ],
        ),

        // Altert Navitagor
        // GoRoute(
        //   path: '/',
        //   builder: (_, state) => HomePage(key: state.pageKey),
        // ),
        // ShellRoute(
        //   navigatorKey: _shellNavigatorKey,
        //   builder: (_, state, child) =>
        //       AppScaffold(key: state.pageKey, child: child),
        //   routes: [
        //     GoRoute(
        //       path: '/',
        //       pageBuilder: (context, state) =>
        //           NoTransitionPage(child: HomePage(key: state.pageKey)),
        //     ),
        //     GoRoute(
        //       path: '/orders',
        //       pageBuilder: (context, state) =>
        //           NoTransitionPage(child: OrdersPage(key: state.pageKey)),
        //     ),
        //     GoRoute(
        //       path: '/about',
        //       pageBuilder: (context, state) =>
        //           NoTransitionPage(child: AboutPage(key: state.pageKey)),
        //     )
        //   ],
        // ),
      ],
    );
  },
);
