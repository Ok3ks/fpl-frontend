import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/themes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import 'package:fpl/leaguepage/leagueview.dart';
import 'package:fpl/individualpage/participantview.dart';
import 'package:fpl/gamepage/gameview.dart';
import 'package:fpl/navigation_services.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
      options:  FirebaseOptions(
          apiKey:dotenv.env['apiKey'] ?? '<API_KEY>',
          authDomain: dotenv.env['authDomain'] ?? "<AUTH_DOMAIN>",
          projectId: dotenv.env['projectId'] ?? "<PROJECT_ID>",
          storageBucket: dotenv.env['storageBucket'] ?? "<STORAGE-BUCKET>",
          messagingSenderId: dotenv.env['messagingSenderId'] ?? "<MESSENGER>",
          appId: dotenv.env['appId'] ?? "<APP_ID>",
          measurementId: dotenv.env['measurementId'] ?? "<MEASUREMENT_ID>"

      ));

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
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
