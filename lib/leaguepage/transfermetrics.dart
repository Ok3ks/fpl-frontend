import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/themes.dart';
import '../utils.dart';

import '../dataprovider.dart';

class TransferMetrics extends StatelessWidget {
  // final String title;
  dynamic data;
  TransferMetrics({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    // List<String> transferImpactKeys = ["bestTransferIn", "worstTransferIn", ""];

    return SizedBox(
        child:
            // Card(
            // color: MaterialTheme.darkMediumContrastScheme().onSurface,
            // elevation: 2,
            // child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
          const Text("Transfer Impact",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                decoration: TextDecoration.none,
              )),
          if (data.data?['leagueWeeklyReport']['bestTransferIn'] != null)
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(2, (index) {
                  return TransferTile(
                      data: data.data?['leagueWeeklyReport']['bestTransferIn'],
                      index: index);
                })),
          if (data.data?['leagueWeeklyReport']['worstTransferIn'] != null)
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(2, (index) {
                  return TransferTile(
                      data: data.data?['leagueWeeklyReport']['worstTransferIn'],
                      index: index);
                }))
        ]));
    // );
  }
}

class TransferTile extends ConsumerWidget {
  dynamic data;
  int index;

  TransferTile({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameweek = ref.watch(gameweekProvider);

    //TODO: Find an elegant way
    List<double> playerIds = List.from([
      double.tryParse(data[index]['playerIn']) ?? 0,
      double.tryParse(data[index]['playerOut']) ?? 0,
    ]);
    return SizedBox(
        width: 600,
        height: 45,
        child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    color: MaterialTheme.darkMediumContrastScheme().primary),
                borderRadius: BorderRadius.circular(8)),
            color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ParticipantName(participantName: data[index]['teamName'], participantId: data[index]['entryId']),
                      playerName(
                        playerId: playerIds[1],
                        notTransfer: false,
                      ),
                      const Icon(
                        Icons.arrow_circle_right_sharp,
                        color: Colors.red,
                      ),
                      const Icon(
                        Icons.arrow_circle_left_sharp,
                        color: Colors.green,
                      ),
                      playerName(
                        playerId: playerIds[0],
                        notTransfer: false,
                      ),
                      SizedBox(
                          // clipBehavior: Clip.hardEdge,
                          height: 40,
                          width: 50,
                          child: Center(
                            child: Text(
                              "${data[index]['pointsDelta']}pts",
                              style: TextStyle(
                                  color: data[index]['pointsDelta'] > 0
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                    ]))));
  }
}

class ParticipantName extends StatelessWidget {

  String participantName;
  double participantId;

  ParticipantName(
      {super.key, required this.participantName, required this.participantId});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text("{$participantName}",
        style: TextStyle(color: MaterialTheme
            .darkMediumContrastScheme()
            .onSurface, fontSize: 10,),),
      onPressed: () async {
        print(participantId);
        // await pullParticipantStats(participantId);
        // route.go('participant view', /id/)
        // localhistory.cache('web page')
      },
    );
  }
}
