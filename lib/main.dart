import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/home/onboarding.dart';
import 'package:fpl/theme_provider.dart';
import 'package:fpl/themes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import 'package:fpl/env.dart';
import 'package:fpl/leaguepage/leagueview.dart';
import 'package:fpl/individualpage/participantview.dart';
import 'package:fpl/gamepage/gameview.dart';
import 'package:fpl/navigation_services.dart';
import 'package:fpl/home/login.dart';
import 'package:fpl/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

import 'package:firebase_core/firebase_core.dart';

import 'dataprovider.dart';
import 'package:fpl/logging.dart';


void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // dynamic res = await pullGameViewStats(true, true, false);
  // print(res);

  await GetStorage.init();

  var app = await Firebase.initializeApp(
      name: 'fpl-frontend',
      options: FirebaseOptions(
          apiKey: Env.apiKey ?? '<API_KEY>',
          authDomain: Env.authDomain ?? "<AUTH_DOMAIN>",
          projectId: Env.projectId ?? "<PROJECT_ID>",
          storageBucket: Env.storageBucket ?? "<STORAGE-BUCKET>",
          messagingSenderId: Env.messagingSenderId ?? "<MESSENGER>",
          appId: Env.appId ?? "<APP_ID>",
          measurementId: Env.measurementId ?? "<MEASUREMENT_ID>"));

  var auth = FirebaseAuth.instanceFor(
    app: app,
  );
  auth.setPersistence(Persistence.LOCAL);
  runApp(const ProviderScope(child: FplApp()));
}

final GoRouter router = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ProviderScope(child: Home());
      },
    ),
    GoRoute(
        path: '/gameview',
        builder: (BuildContext context, GoRouterState state) {
          return const BarChartSample3();
        }),
    GoRoute(
        path: '/leagueview',
        builder: (BuildContext context, GoRouterState state) {
          return ProviderScope(child: LeagueView());
        }),
    GoRoute(
        path: '/participantview',
        builder: (BuildContext context, GoRouterState state) {
          return const ProviderScope(child: ParticipantView());
        }),
    GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const ProviderScope(child: LoginView());
        }),
    GoRoute(
        path: '/onboarding',
        builder: (BuildContext context, GoRouterState state) {
          return const ProviderScope(child: Onboarding());
        }),
    GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const ProviderScope(child: Home());
        }),
  ],
  routerNeglect: true,
);

class FplApp extends ConsumerWidget {
  const FplApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final fplTheme = FplTheme();
    return MaterialApp.router(
      routerConfig: router,
      title: 'FPL Wrapped',
      theme: MaterialTheme().light(),
      darkTheme: MaterialTheme().dark(),
      themeMode: themeMode,
    );
  }
}
