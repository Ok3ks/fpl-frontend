import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/themes.dart';

import '../dataprovider.dart';

class TransferMetrics extends StatelessWidget {
  // final String title;
  dynamic data;
  TransferMetrics({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    List<String> transferImpactKeys = ["bestTransferIn", "worstTransferIn", ""];

    return Card(
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
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(2, (index) {
                    return TransferTile(keys: transferImpactKeys[index], data: data);
                  }))]));
  }
}

class TransferTile extends StatelessWidget {

dynamic data;
String keys;

TransferTile({super.key, required this.data, required this.keys});

  @override
  Widget build(BuildContext context) {
    List<dynamic> bestTransferIn =
    data.data?['leagueWeeklyReport']['bestTransferIn'];
    List<dynamic> worstTransferIn =
    data.data?['leagueWeeklyReport']['worstTransferIn'];

    if (keys == 'bestTransferIn') {
      return SizedBox(
          width: 400,
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
                          "${bestTransferIn.first['pointsDelta']}",
                          style: TextStyle(
                              color: bestTransferIn.first['pointsDelta'] > 0
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(children: [
                          Text(
                            "${bestTransferIn.first['playerIn']}",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface),
                          ),
                          //const SizedBox(width: 20,),
                          Text(
                            "WHU|FUL|ARS",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface,
                                fontSize: 9),
                          ),
                        ]),
                        // if (isOutTransfer)
                        const Icon(
                          Icons.arrow_circle_right_sharp,
                          color: Colors.red,
                        ),
                        // if (isInTransfer)
                        const Icon(
                          Icons.arrow_circle_left_sharp,
                          color: Colors.green,
                        ),
                        Column(children: [
                          Text(
                            "${bestTransferIn.first['playerOut']}",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface),
                          ),
                          //const SizedBox(width: 20,),
                          Text(
                            "WHU|FUL|ARS",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface,
                                fontSize: 9),
                          ),
                        ]),
                        SizedBox(
                          // clipBehavior: Clip.hardEdge,
                            height: 40,
                            width: 50,
                            child: Center(
                              child: Text(
                                "${bestTransferIn.first['teamName']}",
                                style: TextStyle(
                                  color:
                                  MaterialTheme.darkMediumContrastScheme()
                                      .onSurface,
                                  fontSize: 10,
                                ),
                              ),
                            ))
                      ]))));
    } else if (keys == "worstTransferIn") {
      return SizedBox(
          width: 400,
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
                          "${worstTransferIn.first['pointsDelta']}",
                          style: TextStyle(
                              color: bestTransferIn.first['pointsDelta'] < 0
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(children: [
                          Text(
                            "${worstTransferIn.first['playerIn']}",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface),
                          ),
                          //const SizedBox(width: 20,),
                          Text(
                            "WHU|FUL|ARS",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface,
                                fontSize: 9),
                          ),
                        ]),
                        // if (isOutTransfer)
                        const Icon(
                          Icons.arrow_circle_right_sharp,
                          color: Colors.red,
                        ),
                        // if (isInTransfer)
                        const Icon(
                          Icons.arrow_circle_left_sharp,
                          color: Colors.green,
                        ),
                        Column(children: [
                          Text(
                            "${worstTransferIn.first['playerOut']}",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface),
                          ),
                          //const SizedBox(width: 20,),
                          Text(
                            "WHU|FUL|ARS",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface,
                                fontSize: 9),
                          ),
                        ]),
                        SizedBox(
                          // clipBehavior: Clip.hardEdge,
                            height: 40,
                            width: 50,
                            child: Center(
                              child: Text(
                                "${worstTransferIn.first['teamName']}",
                                style: TextStyle(
                                    color:
                                    MaterialTheme.darkMediumContrastScheme()
                                        .onSurface,
                                    fontSize: 10),
                              ),
                            ))
                      ]))));
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
                          "${worstTransferIn.first['pointsDelta']}",
                          style: TextStyle(
                              color: bestTransferIn.first['pointsDelta'] < 0
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(children: [
                          Text(
                            "${worstTransferIn.first['playerIn']}",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface),
                          ),
                          Text(
                            "WHU|FUL|ARS",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface,
                                fontSize: 9),
                          ),
                        ]),
                        const Icon(
                          Icons.arrow_circle_right_sharp,
                          color: Colors.red,
                        ),
                        const Icon(
                          Icons.arrow_circle_left_sharp,
                          color: Colors.green,
                        ),
                        Column(children: [
                          Text(
                            "${worstTransferIn.first['playerOut']}",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface),
                          ),
                          //const SizedBox(width: 20,),
                          Text(
                            "WHU|FUL|ARS",
                            style: TextStyle(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .onSurface,
                                fontSize: 9),
                          ),
                        ]),
                        Text(
                          "${worstTransferIn.first['teamName']}",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface),
                        ),
                      ]))));
    }
  //League Average and visualizing this
  //Bench Act
}
}