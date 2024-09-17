import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpl/themes.dart';

class BenchMetrics extends StatelessWidget {
  
  dynamic data;
  BenchMetrics({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return Card(
        color: MaterialTheme.darkMediumContrastScheme().onSurface,
        elevation: 2,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("Bench Effect",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15
            )),
        Card(
            shadowColor:
                MaterialTheme.darkMediumContrastScheme().secondaryContainer,
            color: MaterialTheme.darkMediumContrastScheme().onSurface,
            child: Column(children: [
              Row(children: [ MostPointsOnBench(data:data)]),
              Row(children: [BenchMetricsCard(data:data), PlayMeInstead(data:data)]),]
            // Text("Bench Points")
            ))]));
  }
    else {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Bench Effect",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12
          )), Card(
              shadowColor:
              MaterialTheme.darkMediumContrastScheme().secondaryContainer,
              color: MaterialTheme.darkMediumContrastScheme().onSurface,
              child: Column(
                  children: [
                    MostPointsOnBench(data:data),
                    BenchMetricsCard(data:data),
                    PlayMeInstead(data:data)]),
                // Text("Bench Points")
              )]);
    }
  }
}

class BenchMetricsCard extends StatelessWidget {
  dynamic data;
  BenchMetricsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    String teamName = data.data?['leagueWeeklyReport']['mostPointsOnBench'].first['teamName'];

    return Row(children: [
      SizedBox(
        width: 200,
        height: 75,
        child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    color: MaterialTheme.darkMediumContrastScheme().primary),
                borderRadius: BorderRadius.circular(18)),
            color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [Text("A",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface)),
                              
                                  Icon(Icons.swipe_up_alt_sharp, color:Colors.green[400], size: 12),
                                  Icon(Icons.swipe_down_alt_sharp, color:Colors.grey[400], size: 12),
                                  Icon(Icons.drag_handle_sharp, color:Colors.yellow[400], size: 12),
                                  ]),
                      Text("B",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface)),
                      Text("C",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface)),
                      Text("D",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface)),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Center(
                      child: Text("Jammy Points",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface, fontSize: 10))),
                ],
              ),
            )),
      )
    ]);
  }
}

// TODO Design in another way
class JammyPointsCard extends StatelessWidget {
  dynamic data;

  JammyPointsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    String teamName = data.data?['leagueWeeklyReport']['mostPointsOnBench'].first['teamName'];
    // print(data.data?['leagueWeeklyReport']['mostPointsOnBench'].first['teamName']); //players points instead of ID

    return Row(children: [
      SizedBox(
        width: 200,
        height: 75,
        child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    color: MaterialTheme.darkMediumContrastScheme().primary),
                borderRadius: BorderRadius.circular(18)),
            color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [Text("A",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface)),
                              
                                  Icon(Icons.swipe_up_alt_sharp, color:Colors.green[400], size: 12),
                                  Icon(Icons.swipe_down_alt_sharp, color:Colors.red[400], size: 12),
                                  Icon(Icons.drag_handle_sharp, color:Colors.yellow[400], size: 12),
                                  ]),
                      Text("B",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface)),
                      Text("C",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface)),
                      Text("D",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface)),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Center(
                      child: Text(teamName,
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface, fontSize: 10))),
                ],
              ),
            )),
      )
    ]);
  }
}

class MostPointsOnBench extends StatelessWidget {
  dynamic data;

  MostPointsOnBench({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.sizeOf(context);
    dynamic mostBenched = data.data?['leagueWeeklyReport']['mostBenched'];

    String mostBenchedPlayer = mostBenched['player'].first;
    double mostBenchedPlayerPoints = mostBenched['points'].first;
    double mostBenchedPlayerCount = mostBenched['count'].first;


    return Row(children: [
      SizedBox(
        width: 200,
        height: 75,
        child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    color: MaterialTheme.darkMediumContrastScheme().primary),
                borderRadius: BorderRadius.circular(18)),
            color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text("$mostBenchedPlayer",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface)),
                      Text("$mostBenchedPlayerPoints",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface)),
                      Text("$mostBenchedPlayerCount",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface)),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Center(
                      child: Text("MostBenched- Player|Points|Count",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface, fontSize: 10))),
                ],
              ),
            )),
      )
    ]);
  }
}


class PlayMeInstead extends StatelessWidget {
  dynamic data;

  PlayMeInstead({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    List<Object?> teams = data.data?['leagueWeeklyReport']['mostPointsOnBench'].first['players'];
    String teamName = data.data?['leagueWeeklyReport']['mostPointsOnBench'].first['teamName'];

    return Row(children: [
      SizedBox(
        width: 200,
        height: 75,
        child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    color: MaterialTheme.darkMediumContrastScheme().primary),
                borderRadius: BorderRadius.circular(18)),
            color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(teams.length, (index) {
                      return playerPoints(index: index, benchData:teams);}
                        )),
                  SizedBox(height: 5),
                  Center(child:Text("Most Points on the Bench", style: TextStyle(
                    color: MaterialTheme.darkMediumContrastScheme()
                        .onSurface, fontSize: 10))
                  )],
              ),
            )),
      ),
      const Text("playMeInstead", style: TextStyle(fontSize: 12),)
    ]);
  }
}
class playerPoints extends StatelessWidget {
  List<Object?> benchData;
  int index;

  playerPoints({super.key, required this.benchData, required this.index});

  @override
  Widget build(BuildContext context) {
    return Text("${benchData[index]}  ",
        style: TextStyle(
  color: MaterialTheme.darkMediumContrastScheme()
  .onSurface,));}}