import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/home/login.dart';
import 'package:fpl/home/onboarding.dart';
import 'package:fpl/individualpage/participantview.dart';
import 'package:fpl/leaguepage/leagueview.dart';
import 'package:fpl/theme_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:fpl/themes.dart';

import 'banner.dart';

void main() {
  runApp(const Home());
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final local = GetStorage();
    final user = ref.read(currentUserProvider);
    final themeMode = ref.watch(themeProvider);

    if (local.read("status") == "registered") {
      return const LoginView();
    } else if (local.read("isLoggedIn") == true) {
      return MaterialApp(
        home: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  // Drawer header with a gradient background.
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      user?.username ?? "",
                      style: TextStyle(
                        color: MaterialTheme.darkMediumContrastScheme().primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    accountEmail: Text(
                      user?.email ?? "",
                      style: TextStyle(
                        color: MaterialTheme.darkMediumContrastScheme().primary,
                        fontSize: 14,
                      ),
                    ),
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage:
                          AssetImage("images/pexels-mike-1171084.webp"),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          MaterialTheme.darkMediumContrastScheme()
                              .primaryContainer, //TODO: configure in Settings
                          MaterialTheme.darkMediumContrastScheme()
                              .secondaryContainer
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Drawer items
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.black54),
                    title: const Text(
                      'Settings',
                      style: TextStyle(fontSize: 16),
                    ),
                    dense: true,
                    onTap: () {
                      // TODO: Handle settings tap
                    },
                  ),
                  const Divider(thickness: 1),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.black54),
                    title: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 16),
                    ),
                    dense: true,
                    onTap: () async {
                      context.go("/login");
                      await user?.logOut();
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              actions: [
                Switch(
                  value: themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    ref.read(themeProvider.notifier).toggleTheme();
                  },
                )
              ],
              backgroundColor: const Color.fromRGBO(80, 100, 80,
                  0), // MaterialTheme.darkMediumContrastScheme().onSurface,
              bottom: const TabBar(
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(text: "League", icon: Icon(Icons.person)),
                  Tab(text: "Participant", icon: Icon(Icons.leaderboard)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ProviderScope(child: LeagueView()),
                const ProviderScope(child: ParticipantView()),
              ],
            ),
          ),
        ),
      );
    }
    return const HomeBanner();
  }
}
