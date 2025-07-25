import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/leaguepage/differential.dart';
import 'package:fpl/themes.dart';
import 'package:fpl/utils.dart';
import 'package:fpl/leaguepage/benchmetrics.dart';
import 'package:fpl/leaguepage/captainmetrics.dart';
import 'package:fpl/leaguepage/transfermetrics.dart';
import 'package:fpl/leaguepage/performancemetrics.dart';
import 'package:fpl/leaguepage/leagueName.dart';
import 'package:fpl/types.dart';
import 'dart:convert';

import '../individualpage/participantview.dart';

class Chat extends ConsumerStatefulWidget {
  double chatBoxWidth;
  Chat({
    super.key,
    required this.chatBoxWidth,
  });

  @override
  ConsumerState<Chat> createState() => ChatState();
}

class ChatState extends ConsumerState<Chat> {
  @override
  Widget build(BuildContext context) {
    final leagueId = ref.watch(leagueProvider)?.leagueId;
    final gameweek = ref.watch(gameweekProvider);

    if (leagueId != null) {
      return Column(children: [
        FutureBuilder(
            future: pullStats(leagueId, gameweek),
            builder: (context, snapshot) {
              var obj = snapshot.data;
              print(snapshot.connectionState);
              if (snapshot.hasData) {
                return chatWidget(data: obj, width: widget.chatBoxWidth);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return chatWidget(
                    data: obj, hydrate: false, width: widget.chatBoxWidth);
              } else {
                return const Text("No Data");
              }
            })
      ]);
    }
    return LandingPage();
  }
}

class chatWidget extends StatelessWidget {
  Map<String, dynamic>? data;
  bool hydrate = true;
  double width;

  chatWidget(
      {super.key,
      required this.data,
      this.hydrate = true,
      required this.width});

  @override
  Widget build(BuildContext context) {
    int msgLength = data?['msgLength'] ?? 2;
    return Column(
        children: List.generate(msgLength, (int index) {
      return SizedBox(
          width: width,
          child: Card(
              margin: const EdgeInsetsGeometry.fromLTRB(7, 10, 7, 0),
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              child: const Text(" " + "Temp",
                  // textAlign: TextAlign.end,
                  textDirection: TextDirection.rtl,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.black26,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  ))));
    }));
  }
}
