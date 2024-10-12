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
    List<String> transferImpactKeys = ["bestTransferIn", "worstTransferIn", ""];

    return SizedBox(
        child: Card(
        color: MaterialTheme.darkMediumContrastScheme().onSurface,
        elevation: 2,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Transfer Impact",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
              if (data.data?['leagueWeeklyReport']['bestTransferIn'] != null)
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(2, (index) {
                    return TransferTile(keys: transferImpactKeys[index], data: data);
                  }))])));
  }
}

class TransferTile extends ConsumerWidget {

dynamic data;
String keys;

TransferTile({super.key, required this.data, required this.keys});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final gameweek = ref.watch(gameweekProvider);

    List<dynamic> bestTransferIn =
    data.data?['leagueWeeklyReport']['bestTransferIn'];
    List<dynamic> worstTransferIn =
    data.data?['leagueWeeklyReport']['worstTransferIn'];

    // List<double> playerIds = bestTransferIn.map((e) => double.tryParse(e['playerIn']) ?? 0).toList();

    //TODO: Find an elegant way
    List<double> playerIds = List.from([double.tryParse(bestTransferIn[0]['playerIn']) ?? 0, double.tryParse(bestTransferIn[0]['playerOut']) ?? 0,
                    double.tryParse(worstTransferIn[0]['playerIn']) ?? 0, double.tryParse(worstTransferIn[0]['playerOut']) ?? 0]);
    
    List<String> teamName = List.from([bestTransferIn[0]['teamName'],
                  worstTransferIn[0]['teamName'],]);

    List<double> delta = List.from([bestTransferIn[0]['pointsDelta'],
                  worstTransferIn[0]['pointsDelta'],]);

    return FutureBuilder(
        future: pullPlayersStats(playerIds, gameweek),
        builder: (context, snapshot) {
        var obj = snapshot.data;

    // print(bestTransferIn);
    // print(worstTransferIn);

    if (keys == 'bestTransferIn') {
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
      Text(
    "${teamName[0]}",
    style: TextStyle(
    color:
    MaterialTheme.darkMediumContrastScheme()
        .onSurface,
    fontSize: 10,
    ),
    ),
      playerName(playerId: playerIds[1], notTransfer: false,),
      const Icon(
    Icons.arrow_circle_right_sharp,
    color: Colors.red,
    ),
    // if (isInTransfer)
    const Icon(
    Icons.arrow_circle_left_sharp,
    color: Colors.green,
    ),
      playerName(playerId: playerIds[0], notTransfer: false,),
      SizedBox(
    // clipBehavior: Clip.hardEdge,
    height: 40,
    width: 50,
    child: Center(
    child: Text(
    "${delta[0]}pts",
    style: TextStyle(
    color: bestTransferIn.last['pointsDelta'] > 0
    ? Colors.green
        : Colors.red,
    fontWeight: FontWeight.bold),
    ),
    ))
    ]))));
    } else if (keys == "worstTransferIn") {
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

    //There are Bigs here as regards accessing arrays. Wonder why dart works this way


    Text(
    "${teamName[1]}",
    style: TextStyle(
    color: MaterialTheme.darkMediumContrastScheme()
        .onSurface, fontSize: 10 ),
    ),
      playerName(playerId: playerIds[2], notTransfer: false,),
      const Icon(
    Icons.arrow_circle_right_sharp,
    color: Colors.red,
    ),
    const Icon(
    Icons.arrow_circle_left_sharp,
    color: Colors.green,
    ),
      playerName(playerId: playerIds[3], notTransfer: false,),
      SizedBox(
    // clipBehavior: Clip.hardEdge,
    height: 40,
    width: 50,
    child: Center(
    child: Text(
    "${delta[1]}pts",
    style: TextStyle(
    color: worstTransferIn[0]['pointsDelta'] < 0
    ? Colors.red
        : Colors.green,
    fontWeight: FontWeight.bold),
    ),

    ))]))));
    } else {
    return SizedBox(
    width: 500,
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
    Text(
    "${teamName[0]}",
    style: TextStyle(
    color: MaterialTheme.darkMediumContrastScheme()
        .onSurface),
    ),
    Text(
    "${worstTransferIn.first['playerIn']}",
    style: TextStyle(
    color: MaterialTheme.darkMediumContrastScheme()
        .onSurface),
    ),
    const Icon(
    Icons.arrow_circle_right_sharp,
    color: Colors.red,
    ),
    const Icon(
    Icons.arrow_circle_left_sharp,
    color: Colors.green,
    ),
    //Column(children: [
    Text(
    "${teamName[0]}",
    style: TextStyle(
    color: MaterialTheme.darkMediumContrastScheme()
        .onSurface),
    ),
    const SizedBox(width: 20,),

    Text(
    "${delta[0]}",
    style: TextStyle(
    color: worstTransferIn.first['pointsDelta'] < 0
    ? Colors.green
        : Colors.red,
    fontSize: 10,
    fontWeight: FontWeight.bold),
    ),

    
    ]))));
    }
  });
}}


