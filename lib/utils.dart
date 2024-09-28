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
    var response = await client.post(
        Uri.https(Constants.fplUrl),
        body: {});
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

    final  currGameweek = ref.watch(gameweekProvider);

    //TODO:Limit based on current gameweek
    return FutureBuilder(
        future: getCurrentGameweek(),
        builder: (BuildContext, snapshot) {
          return SizedBox(
              height: 50,
              width: 180,
              child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 0,
                          color:
                          MaterialTheme.darkMediumContrastScheme().primaryContainer),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.keyboard_arrow_left, size: 15, color: Colors.white,),
                            onPressed: () {
                              final prevGameweek = ref.watch(gameweekProvider);
                              if (prevGameweek - 1 >= 1) {
                                ref
                                    .watch(gameweekProvider.notifier)
                                    .state = prevGameweek - 1;
                              }}),
                        SizedBox(
                          width: 80,
                          height: 50,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.5,
                                      color: MaterialTheme.darkMediumContrastScheme().primary),
                                  borderRadius: BorderRadius.circular(18)),
                              color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
                              child: Center(
                                child:Text(currGameweek.toString(),
                                    style: TextStyle(color:MaterialTheme.darkMediumContrastScheme().onSurface, fontSize: 15)),
                              )),),
                        IconButton(
                            icon: const Icon(Icons.keyboard_arrow_right, size: 15,color: Colors.white,),
                            onPressed: () {
                              if (currGameweek + 1 <= 38) {
                                ref.watch(gameweekProvider.notifier).state = currGameweek +1;
                              }
                            }
                        ),

                      ])));

        });
  }
}


class playerName extends ConsumerWidget {
  double playerId;
  playerName({super.key, required this.playerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameweek = ref.watch(gameweekProvider);
    return FutureBuilder(
        future: pullPlayerStats(playerId, gameweek),
        builder: (context, snapshot) {
          var obj = snapshot.data;

          // Text(
          // "WHU|FUL|ARS",
          // style: TextStyle(
          // color: MaterialTheme.darkMediumContrastScheme()
          //     .onSurface,
          // fontSize: 9),
          // ),
          //]),
          return
                      SizedBox(
              //width: 60,
              height: 20,
                child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                TextButton(
                  child: Text("${obj.data?['player']['info']['playerName'].toString().split(" ").last}",
                      style: TextStyle(
                          color: MaterialTheme.darkMediumContrastScheme()
                              .onSurface, fontSize: 12)),
                  onPressed: () {
                    // return SizedBox(
                    //   width: 55,
                    //   child: Text("${obj.data?['player']['info']['playerName'].toString()}",
                    //       style: TextStyle(
                    //           color: MaterialTheme.darkMediumContrastScheme()
                    //               .onSurface, fontSize: 7)),
                    // );
                  }
                  ,), 
                  Text("${obj.data?['player']['gameweekScore']['totalPoints']}pts",
                      style: TextStyle(
                          color: MaterialTheme.darkMediumContrastScheme()
                              .onSurface, fontSize: 12)),
                  ]));});
  }
}

