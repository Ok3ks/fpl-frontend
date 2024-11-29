import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/individualpage/participantview.dart';
import 'package:fpl/leaguepage/leagueview.dart';

import '../themes.dart';

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
            backgroundColor: Color.fromRGBO(80, 100, 80,
                0), // MaterialTheme.darkMediumContrastScheme().onSurface,
            bottom: const TabBar(
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
              Icon(Icons.sports_soccer),
            ],
          ),
        ),
      ),
    );
  }
}
