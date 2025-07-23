import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/home/login.dart';
import 'package:fpl/individualpage/participantview.dart';
import 'package:fpl/leaguepage/leagueview.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:fpl/themes.dart';

void main() {
  runApp(const Home());
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final local = GetStorage();
    final user = ref.read(currentUserProvider);

    if (local.read("isLoggedIn") == true) {
      return MaterialApp(
        home: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Drawer header containing user profile infos.
                  UserAccountsDrawerHeader(
                    accountName: Text(user?.username ?? "",
                        style: TextStyle(
                            color: MaterialTheme.darkMediumContrastScheme()
                                .primary)),
                    accountEmail: Text(user?.email ?? "",
                        style: TextStyle(
                            color: MaterialTheme.darkMediumContrastScheme()
                                .primary)),
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage:
                          AssetImage("images/pexels-mike-1171084.webp"),
                    ),
                    decoration: BoxDecoration(
                        color: MaterialTheme.darkMediumContrastScheme()
                            .primaryContainer //Customize
                        ),
                  ),
                  // Add any other drawer items you want.
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      //TODO: Handle settings tap
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () async {
                      context.go("/login");
                      await user?.logOut();
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(80, 100, 80,
                  0), // MaterialTheme.darkMediumContrastScheme().onSurface,
              bottom: const TabBar(
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(text: "Participant", icon: Icon(Icons.person)),
                  Tab(text: "League", icon: Icon(Icons.leaderboard)),
                ],
              ),
              // title: const Text('Tabs Demo'),
            ),
            body: TabBarView(
              children: [
                const ProviderScope(child: ParticipantView()),
                ProviderScope(child: LeagueView()),
              ],
            ),
          ),
        ),
      );
    }
    return const LoginView();
  }
}
