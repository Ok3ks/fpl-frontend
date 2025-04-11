import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/themes.dart';
import 'package:fpl/utils.dart';
import 'dart:html' as html;

class BenchMetrics extends StatefulWidget {
  final Map<String, dynamic>? data;

  BenchMetrics({super.key, required this.data});

  @override
  State<BenchMetrics> createState() => BenchMetricsState();
}

class BenchMetricsState extends State<BenchMetrics> {
  final yourScrollController = ScrollController(
    onAttach: (position) {},
    onDetach: (position) {},
  );

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    if (widget.data != null) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Scrollbar(
                thickness: 2,
                trackVisibility: true,
                controller: yourScrollController,
                radius: const Radius.circular(3),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        JammyPointsCard(data: widget.data),
                        HighestPointsBenched(data: widget.data),
                        PlayMeInstead(data: widget.data),
                      ]),
                  // Text("Bench Points")
                ))
            // )
          ]);
    } else {
      //replace with animation maybe
      return CircularProgressIndicator();
    }
  }
}

class JammyPointsCard extends ConsumerWidget {
  Map<String, dynamic>? data;
  JammyPointsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final Size size = MediaQuery.sizeOf(context);
    var obj = data?['leagueWeeklyReport']['jammyPoints'];

    String teamName = obj[0]['teamName'];
    int points = obj[0]['points'];
    print(points);

    if (points != 0) {
      // print(obj[0]);
      List<dynamic> playersSubIn = obj[0]['subIn'];
      List<dynamic> playersSubOut = obj[0]['subOut'];

      return Row(children: [
        SizedBox(
          child: Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.5,
                      color: MaterialTheme.darkMediumContrastScheme().primary),
                  borderRadius: BorderRadius.circular(18)),
              color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 3),
                    Center(
                        child: Text("Jammy Points ",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface,
                                fontSize: 10))),
                    const SizedBox(height: 3),
                    Column(
                        children: List.generate(playersSubIn.length, (index) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.swipe_down_alt_sharp,
                                color: Colors.red[400], size: 12),
                            playerName(
                                playerId: int.parse(
                                        playersSubOut[index].toString() ??
                                            "0") ??
                                    0),
                            Icon(Icons.swipe_up_alt_sharp,
                                color: Colors.green[400], size: 12),
                            playerName(
                                playerId: int.parse(
                                        playersSubIn[index].toString() ??
                                            "0") ??
                                    0),
                          ]);
                    })),
                    const SizedBox(height: 9),
                    Center(
                        child: Text("$teamName",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .primary,
                                fontSize: 10))),
                  ],
                ),
              )),
        )
      ]);
      // });
    } else {
      return SizedBox.shrink();
    }
  }
}

class HighestPointsBenched extends ConsumerWidget {
  Map<String, dynamic>? data;
  HighestPointsBenched({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.sizeOf(context);
    final gameweek = ref.watch(gameweekProvider);
    dynamic highestBenched = data?['leagueWeeklyReport']['mostBenched'];

    String? highestBenchedPlayer = highestBenched?['player'].first;

    return Column(children: [
      SizedBox(
        // width: 100,
        // height: 100,
        child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    color: MaterialTheme.darkMediumContrastScheme().primary),
                borderRadius: BorderRadius.circular(18)),
            color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                      // width: 106,
                      child: Text("Highest Points Benched",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 10))),
                  playerName(
                      playerId: int.parse(highestBenchedPlayer ?? '0') ?? 0),
                ],
              ),
            )),
      )
    ]);
    // });
    // } else {
    //   return Text("No data");
    // }
  }
}

class PlayMeInstead extends StatelessWidget {
  Map<String, dynamic>? data;

  PlayMeInstead({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    List<Object?>? teams =
        data?['leagueWeeklyReport']['mostPointsOnBench'].first['players'];
    String? teamName =
        data?['leagueWeeklyReport']['mostPointsOnBench'].first['teamName'];

    //ToDo: add entryId to graphqlschema, need to update django backend. Maybe Version and aggregate all changes

    return Column(children: [
      SizedBox(
          // width: 270,
          // height: 100,
          child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.5,
                color: MaterialTheme.darkMediumContrastScheme().primary),
            borderRadius: BorderRadius.circular(18)),
        color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 3),
                  Center(
                      child: Text("Most Points on the Bench",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface,
                              fontSize: 10))),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(teams?.length ?? 0, (index) {
                        return playerName(
                            playerId:
                                int.parse(teams?[index].toString() ?? "0") ??
                                    0);
                      })),
                  // playerPoints(index: index, benchData:teams);}
                  // )),
                  const SizedBox(height: 5),
                  Center(
                    child: Text("$teamName",
                        style: TextStyle(
                          color:
                              MaterialTheme.darkMediumContrastScheme().primary,
                          fontSize: 10,
                        )),
                  ),
                ])),
      ))
    ]);
    // ]);
  }
}
