import 'package:flutter/material.dart';
import 'package:fpl/themes.dart';

class PerformanceMetrics extends StatelessWidget {
  dynamic data;

  PerformanceMetrics({super.key, required this.data});

  final double gap = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Align(
              alignment: Alignment.bottomLeft,
              child: Text("Performance",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ))),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MetricsCard(
                title: "Exceptional ",
                data: data['leagueWeeklyReport']['exceptional']),
            LeagueAverageCard(
                title: "League Average",
                data: data['leagueWeeklyReport']),
            if ((data != null) &&
                (data['leagueWeeklyReport']['abysmal']['score'] != null))
              MetricsCard(
                  title: "Abysmal ",
                  data: data['leagueWeeklyReport']['abysmal']),
          ])
          // ),
        ]);
    // );
  }
}

class MetricsCard extends StatelessWidget {
  final String title;
  dynamic data;
  MetricsCard({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Row(children: [
      SizedBox(
        width: 100,
        // height: 100,
        child: Card(
            // shadowColor: MaterialTheme.darkMediumContrastScheme().primary,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    color: MaterialTheme.darkMediumContrastScheme().primary),
                borderRadius: BorderRadius.circular(18)),
            color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title,
                      style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  // children: [
                  Text(
                    "${data?['score'].toString()}",
                    style: TextStyle(
                        fontSize: 25,
                        // fontWeight: FontWeight.bold,
                        color:
                            MaterialTheme.darkMediumContrastScheme().primary),
                  ),
                  // Text("pts", style: TextStyle(fontSize: 10, color: MaterialTheme.darkMediumContrastScheme().primary))
                  // ]),
                  // const SizedBox(height: 7.5),
                  Text("${data?['teamName'].toString()}",
                      style: TextStyle(
                          fontSize: 10,
                          // fontWeight: FontWeight.bold,
                          color: MaterialTheme.darkMediumContrastScheme()
                              .primary)),
                  // Align(
                  //     alignment: Alignment.bottomRight,
                  //     child: Icon(Icons.copyright,
                  //         size: 18,
                  //         fill: 0,
                  //         color: MaterialTheme.darkMediumContrastScheme()
                  //             .onSurface))
                ],
              ),
            )),
      )
    ]);
  }
}

class LeagueAverageCard extends StatelessWidget {
  final String title;
  dynamic data;
  LeagueAverageCard({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Row(children: [
      SizedBox(
        width: 125,
        child: Card(
            // shadowColor: MaterialTheme.darkMediumContrastScheme().primary,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    color: MaterialTheme.darkMediumContrastScheme().primary),
                borderRadius: BorderRadius.circular(18)),
            color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title,
                      style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  Text(
                    "${data?['leagueAverage'].ceilToDouble().toString()}",
                    style: TextStyle(
                        fontSize: 25,
                        // fontWeight: FontWeight.bold,
                        color:
                            MaterialTheme.darkMediumContrastScheme().primary),
                  ),
                  // Text("pts", style: TextStyle(fontSize: 10, color: MaterialTheme.darkMediumContrastScheme().primary))

                  // ]),
                  // const SizedBox(height: 7.5),
                  // Align(
                  //     alignment: Alignment.bottomRight,
                  //     child: Icon(Icons.copyright,
                  //         size: 18,
                  //         fill: 0,
                  //         color: MaterialTheme.darkMediumContrastScheme()
                  //             .onSurface))
                ],
              ),
            )),
      )
    ]);
  }
}
