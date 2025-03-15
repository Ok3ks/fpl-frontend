import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'dataprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/themes.dart';

dynamic getCurrentGameweek() async {
  var client = http.Client();
  try {
    var response = await client.post(Uri.https(Constants.fplUrl), body: {});
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var uri = Uri.parse(decodedResponse['uri'] as String);
    // print(await client.get(uri));
  } finally {
    client.close();
  }
  // var url =  Uri.https(Constants.fplUrl);
  // print(url);
  // var response = await http.post(url, body: {});
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
  //
  // print(await http.read(Uri.https('example.com', 'foobar.txt')));
}

class GameweekWidget extends ConsumerWidget {
  GameweekWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currGameweek = ref.watch(gameweekProvider);

    //TODO:Limit based on current gameweek
    return FutureBuilder(
        future: getCurrentGameweek(),
        builder: (BuildContext, snapshot) {
          return SizedBox(
              height: 50,
              // width: 180,
              child: Card(
                  color: Color.fromRGBO(100, 100, 100, 0),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 0,
                          color: MaterialTheme.darkMediumContrastScheme()
                              .primaryContainer),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 15,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              final prevGameweek = ref.watch(gameweekProvider);
                              if (prevGameweek - 1 >= 1) {
                                ref.watch(gameweekProvider.notifier).state =
                                    prevGameweek - 1;
                              }
                            }),
                        SizedBox(
                          width: 40,
                          height: 50,
                          child: Card(
                              color: Color.fromRGBO(100, 100, 100, 0),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.5,
                                      color: MaterialTheme
                                              .darkMediumContrastScheme()
                                          .primary),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(currGameweek.toString(),
                                    style: TextStyle(
                                        color: MaterialTheme
                                                .darkMediumContrastScheme()
                                            .onSurface,
                                        fontSize: 15)),
                              )),
                        ),
                        IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_right,
                              size: 15,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (currGameweek + 1 <= 38) {
                                ref.watch(gameweekProvider.notifier).state =
                                    currGameweek + 1;
                              }
                            }),
                      ])));
        });
  }
}

class leagueIDWidget extends ConsumerWidget {
  leagueIDWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currleague = ref.watch(leagueProvider);

    //TODO:Limit based on current gameweek
    return SizedBox(
      height: 30,
      width: 180,
      child: Card(
        color: Color.fromRGBO(100, 100, 100, 0),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0,
                color:
                    MaterialTheme.darkMediumContrastScheme().primaryContainer),
            borderRadius: BorderRadius.circular(4)),
        child: SizedBox(
            // width: 80,
            // height: 50,
            child: Center(
          child: Text("League Id : ${currleague.toString()}",
              style: TextStyle(
                  color: MaterialTheme.darkMediumContrastScheme().onSurface,
                  fontSize: 15)),
        )),
      ),
    );
  }
}

class participantIdWidget extends ConsumerWidget {
  participantIdWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currUser = ref.watch(currentUserProvider);

    //TODO:Limit based on current gameweek
    return SizedBox(
      height: 30,
      width: 180,
      child: Card(
        color: Color.fromRGBO(100, 100, 100, 0),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0,
                color:
                MaterialTheme.darkMediumContrastScheme().primaryContainer),
            borderRadius: BorderRadius.circular(4)),
        child: SizedBox(
          // width: 80,
          // height: 50,
            child: Center(
              child: Text("Current User: ${currUser?.fplUrl.toString()}",
                  style: TextStyle(
                      color: MaterialTheme.darkMediumContrastScheme().onSurface,
                      fontSize: 15)),
            )),
      ),
    );
  }
}

class playerName extends ConsumerWidget {
  int playerId;
  bool? notTransfer;

  playerName({super.key, this.notTransfer, required this.playerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameweek = ref.watch(gameweekProvider);
    return FutureBuilder(
        future: pullPlayerStats(playerId, gameweek),
        builder: (context, snapshot) {
          var obj = snapshot.data;
          return SizedBox(
              // width: 60,
              // height: 50,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
                // width: 75,
                child: TextButton(
              child: Text(
                  "${obj.data?['player']['info']['playerName'].toString().split(" ").last}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MaterialTheme.darkMediumContrastScheme().onSurface,
                      fontSize: 10)),
              onPressed: () {},
            )),
            if (notTransfer ?? true)
              Text("${obj.data?['player']['gameweekScore']['totalPoints']}",
                  style: TextStyle(
                      color: MaterialTheme.darkMediumContrastScheme().primary,
                      fontSize: 12)),
          ]));
        });
  }
}

String? parseLeagueCodeFromUrl(String url) {
  try {
    final uri = Uri.parse(url); // Parse the URL to handle it more reliably
    final RegExp regExp = RegExp(r'leagues/(\d+)/standings');
    final match = regExp.firstMatch(uri.path);

    if (match != null && match.groupCount >= 1) {
      return match.group(1); // group(1) will contain the league code
    }
    return null; // Return null if no league code is found
  } on FormatException {
    // Handle invalid URL
    return null;
  }
}

String parseParticipantIdFromUrl(String url) {
  final uri = Uri.parse(url); // Parse the URL to handle it more reliably
  final RegExp regExp = RegExp(r'entry/(\d+)/event/(\d+)');
  final match = regExp.firstMatch(uri.path);
  return match?.group(1) ??
      "No participant ID"; // group(1) will contain the participant code
}