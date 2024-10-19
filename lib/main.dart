import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/themes.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fpl/leaguepage/leagueview.dart';
import 'package:fpl/individualpage/participantview.dart';
import 'package:fpl/gamepage/gameview.dart';
import 'package:fpl/navigation_services.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const FplApp());
}

final GoRouter router = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return ProviderScope(child: LeagueView());
      },
    ),
    GoRoute(
        path: '/GameView',
        builder: (BuildContext context, GoRouterState state) {
          return const GameView();
        }),
    GoRoute(
        path: '/participant',
        builder: (BuildContext context, GoRouterState state) {
          return const ParticipantView();
        }),
  ],
  routerNeglect: true,
);

class FplApp extends StatelessWidget {
  const FplApp({super.key});

  @override
  Widget build(BuildContext context) {
    const fplTheme = FplTheme();
    return MaterialApp.router(
      routerConfig: router,
      title: 'League Analysis',
      theme: fplTheme.toThemeData(),
    );
  }
}
