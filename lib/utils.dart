import 'dart:convert';
import 'dart:math';

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
                  color: const Color.fromRGBO(100, 100, 100, 0),
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
                          width: 50,
                          height: 50,
                          child: Card(
                              color: const Color.fromRGBO(100, 100, 100, 0),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.5,
                                      color: MaterialTheme
                                              .darkMediumContrastScheme()
                                          .primary),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: TextButton(
                                  // onFocusChange: ,
                                  // onHover: ,
                                  child: Text(currGameweek.toString(),
                                      style: TextStyle(
                                          color: MaterialTheme
                                                  .darkMediumContrastScheme()
                                              .onSurface,
                                          fontSize: 15)),
                                  onPressed: () {
                                    ref
                                        .read(expandGameweekProvider.notifier)
                                        .state = true;
                                  },
                                ),
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

final expandGameweekProvider = StateProvider<bool>((ref) {
  return false;
});

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
        color: const Color.fromRGBO(100, 100, 100, 0),
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

class expandedGameweekWidget extends ConsumerWidget {
  expandedGameweekWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameweek = ref.watch(gameweekProvider);
    final enabled = ref.watch(expandGameweekProvider);

    //TODO:Limit based on current gameweek
    if (enabled) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(8, (index) {
            double itemGw = max(gameweek - index, 0);
            if (itemGw != 0) {
              return SizedBox(
                  height: 25,
                  width: 50,
                  child: Card(
                      color: const Color.fromRGBO(100, 100, 100, 0),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 0,
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .primaryContainer),
                          borderRadius: BorderRadius.circular(4)),
                      child: TextButton(
                        onPressed: () {
                          ref.read(gameweekProvider.notifier).state = itemGw;
                        },
                        child: Text(
                          itemGw.toString(),
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 10),
                        ),
                      )));
            } else {
              return SizedBox.shrink();
            }
          }));
    } else {
      return SizedBox.shrink();
    }
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
        color: const Color.fromRGBO(100, 100, 100, 0),
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
          child: Text("Current User: ${currUser?.participantId.toString()}",
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
  bool? vertical;

  playerName({super.key, this.vertical, required this.playerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameweek = ref.watch(gameweekProvider);
    return FutureBuilder(
        future: pullPlayerStats(playerId, gameweek),
        builder: (context, snapshot) {
          var obj = snapshot.data;
          if (snapshot.hasData) {
            // return ParticipantStats(data: obj);
            if (vertical ?? true) {
              return SizedBox(
                  // width: 60,
                  // height: 50,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    SizedBox(
                        // width: 75,
                        child: TextButton(
                      child: Text(
                          "${obj.data?['player']['info']['playerName'].toString().split(" ").last}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface,
                              fontSize: 10)),
                      onPressed: () {},
                    )),
                    Text(
                        "${obj.data?['player']['gameweekScore']['totalPoints']}",
                        style: TextStyle(
                            color: MaterialTheme.darkMediumContrastScheme()
                                .primary,
                            fontSize: 12)),
                  ]));
            } else {
              return SizedBox(
                  // width: 60,
                  // height: 50,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    SizedBox(
                        // width: 75,
                        child: TextButton(
                      child: Text(
                          "${obj.data?['player']['info']['playerName'].toString().split(" ").last}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface,
                              fontSize: 10)),
                      onPressed: () {},
                    )),
                    Text(
                        "${obj.data?['player']['gameweekScore']['totalPoints']}",
                        style: TextStyle(
                            color: MaterialTheme.darkMediumContrastScheme()
                                .primary,
                            fontSize: 12)),
                  ]));
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Text("No Data");
          }
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

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    return SizedBox(
        width: width,
        height: 15,
        child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    color: MaterialTheme.darkMediumContrastScheme().primary),
                borderRadius: BorderRadius.circular(8)),
            color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
            child: Text("")));
  }
}
