import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/home/login.dart';
import 'package:fpl/individualpage/participantview.dart';
import 'package:fpl/leaguepage/leagueview.dart';
import 'package:fpl/main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const Home());
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final local = GetStorage();
    final user = ref.read(currentUserProvider);

    void _logout(BuildContext context) {
      // Here you would typically clear user data and navigate to the login screen.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User logged out.')),
      );
      // For example:
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    }

    if (local.read("isLoggedIn") == true) {
      return MaterialApp(
        home: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Drawer header containing user profile infos.
                  UserAccountsDrawerHeader(
                    accountName: Text(user?.username ?? ""),
                    accountEmail: Text(user?.email ?? ""),
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage:  AssetImage("images/pexels-mike-1171084.webp"),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  // Add any other drawer items you want.
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      // Handle settings tap
                      Navigator.pop(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      _logout(context);
                      Navigator.pop(context);
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
                  Tab(text: "individual view", icon: Icon(Icons.person)),
                  Tab(text: "league view", icon: Icon(Icons.leaderboard)),
                  Tab(
                      text: "game view",
                      icon: Icon(
                        Icons.sports_soccer,
                        // onPressed: () async {
                        //     pullGameweekStats(true, true, false)
                        // },
                      ))
                ],
              ),
              // title: const Text('Tabs Demo'),
            ),
            body: TabBarView(
              children: [
                ProviderScope(child: ParticipantView()),
                ProviderScope(child: LeagueView()),
                const Icon(Icons.sports_soccer),
              ],
            ),
          ),
        ),
      );
    }
    return LoginView();
  }
}
