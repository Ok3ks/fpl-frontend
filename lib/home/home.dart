import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/leaguepage/leagueview.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "individual view", icon: Icon(Icons.person)),
                Tab(text: "league view", icon: Icon(Icons.leaderboard)),
                Tab(text: "game view", icon: Icon(Icons.sports_soccer))
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              ProviderScope(child: LeagueView()),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}