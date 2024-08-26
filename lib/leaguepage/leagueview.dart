import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/themes.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeagueView extends StatelessWidget {
  const LeagueView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    return Row(children: [
      ChooseLeague(),
      Container(
        color: MaterialTheme.darkMediumContrastScheme().onSurface,
        child:Column(children: [AMetrics(), PointsMetrics(title: "Points",), BMetrics(), TransferMetrics()])
    )]);
  }
}

class ChooseLeague extends StatelessWidget {
  const ChooseLeague({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    return SizedBox(width: width / 3, height: height, child: Card());
  }
}

class AMetrics extends StatelessWidget {
  AMetrics({super.key});

  final double gap = 10;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width * 2 / 3;
    final double height = size.height;

    return SizedBox(
        width: width,
        //height: height,
        child: Card(
            shadowColor: MaterialTheme.darkMediumContrastScheme().secondaryContainer,
            color: MaterialTheme.darkMediumContrastScheme().onSurface,
            //elevation: 0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Metrics",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              //if (width > 500) : //Switch to list view
              SizedBox(height:20),
              Row(children: [
                MetricsCard(title: "Differential Captain"),
                MetricsCard(title: "Highest Captain"),
                MetricsCard(title: "Highest capped")
              ]),
              Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: Transform.rotate(
                          angle: 55,
                          child: Icon(Icons.expand_circle_down_outlined,
                              size: 18))))
            ])));
  }
}


class BMetrics extends StatelessWidget {
  BMetrics({super.key});

  final double gap = 10;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width * 2 / 3;
    final double height = size.height;

    return SizedBox(
        width: width,
        //height: height,
        child: Card(
            color: MaterialTheme.darkMediumContrastScheme().onSurface,
            //elevation: 0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Points",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              //if (width > 500) : //Switch to list view
              Row(children: [
                MetricsCard(title: "Top differential"),
                MetricsCard(title: "Captain"),
                MetricsCard(title: "Bench/Auto-sub")
              ]),
              Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: Transform.rotate(
                          angle: 55,
                          child: Icon(Icons.expand_circle_down_outlined,
                              size: 18))))
            ])));
  }
}

class LeagueRank extends StatelessWidget {
  const LeagueRank({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("League-Rank 1/ Total Points");
  }
}

// class WeeklyAverage extends StatelessWidget {
//   const WeeklyAverage({super.key});

//   final double gap = 10;

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.sizeOf(context);
//     final double width = size.width * 2 / 3;

//     return SizedBox(
//         width: width - gap * 2,
//         height: 100,
//         child: Card(
//           color: Colors.blue,
//           child: Row(
//               children: List.generate(4, (index) {
//             return Container(
//                 width: 50,
//                 color: Colors.grey,
//                 child: const Column(children: [const Text("10")]));
//           })),
//         ));
//   }
// }

class MetricsCard extends StatelessWidget {
  final String title;
  const MetricsCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Row(children: [
      SizedBox(
        width: 200,
        height: 150,
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
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.white)),
                  SizedBox(height: 7.5),
                  Text(
                    "25",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color:
                            MaterialTheme.darkMediumContrastScheme().primary),
                  ),
                  Text(
                    "Comments",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color:
                            MaterialTheme.darkMediumContrastScheme().onSurface),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.copyright,
                          size: 18,
                          fill: 0,
                          color: MaterialTheme.darkMediumContrastScheme()
                              .onSurface))
                ],
              ),
            )),
      )
    ]);
  }
}


class TransferMetrics extends StatelessWidget {
  // final String title;
  const TransferMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Column(children: 
    List.generate(3, (index) {
      return TransferTile();
    }));
  }
}


class PointsMetrics extends StatelessWidget {
  final String title;
  const PointsMetrics({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    double leagueAverage = values["league_average"];

    return 
    Row(children: [
      SizedBox(
        width: 200,
        height: 150,
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
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.white)),
                  SizedBox(height: 7.5),
                  Text(
                    "${leagueAverage.ceilToDouble()}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color:
                            MaterialTheme.darkMediumContrastScheme().primary),
                  ),
                  Text(
                    "Comments",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color:
                            MaterialTheme.darkMediumContrastScheme().onSurface),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.copyright,
                          size: 18,
                          fill: 0,
                          color: MaterialTheme.darkMediumContrastScheme()
                              .onSurface))
                ],
              ),
            )),
      )
    ]);
  }
}

class TransferTile extends StatelessWidget {
  const TransferTile({super.key});

  @override 
  Widget build(BuildContext context) {
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
        child: 
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text("Bernardo ", style: TextStyle(color: MaterialTheme.darkMediumContrastScheme().onSurface),),
          //const SizedBox(width: 20,),
          Text("WHU|FUL|ARS", style: TextStyle(color: MaterialTheme.darkMediumContrastScheme().onSurface, fontSize: 10),),
          const Icon(Icons.arrow_circle_right_sharp, color: Colors.red,),
          const Icon(Icons.arrow_circle_left_sharp, color: Colors.green,),
          Text("18", style: TextStyle(color: MaterialTheme.darkMediumContrastScheme().primary, fontSize: 10, fontWeight: FontWeight.bold),),

        ]))));

        //League Average and visualizing this
        //Bench Act
  }
}

Map<String, dynamic> loadFile(String jsonPath) {

  String jsonString = """ {"captain": {"328": 8, "401": 6, "351": 4, "317": 1}, "promoted_vice": [], "chips": {},
                           "exceptional": [["Hashira", 89]], "abysmal": [], "league_average": 67.84210526315789, "rise": [], "fall": [[19, 0, "Ayodeji Omoniyi"], [18, 0, "coker sunkanmi"], [17, 0, "Hassan Howlader"], [15, 0, "Martins Omoniyi"]], "most_transferred_out": [], "least_transferred_out": [], "most_transferred_in": [], "least_transferred_in": [], "best_transfer_in": [], "worst_transfer_in": [], "most_points_on_bench": [["Potters touch", {"Dean Henderson": 2, "Harry Winks": 2, "Jo\u0161ko Gvardiol": 7, "Wout Faes": 1}, 12], ["Just Chillin'", {"Mark Flekken": 4, "Rodrigo Muniz Carvalho": 2, "Antonee Robinson": 2, "Valent\u00edn Barco": 0}, 8], ["Sukeyinc", {"Robert S\u00e1nchez": 2, "Joachim Andersen": 0, "Ezri Konsa Ngoyo": 2,
                           "Harry Winks": 2}, 6]], "jammy_points": [["Bulldozers FC", ["Antonee Robinson", "Wout Faes"],
                          ["Kyle Walker", "Valent\u00edn Barco"], 3], ["Potters touch", [], [], 0], ["the eye test", [], [], 0]]} """;
  // Parse JSON string into a Map
  final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  print(jsonMap);
  return jsonMap;
}

Map<String, dynamic> values = loadFile("jsonPath");
//List<dynamic> fixtureRows = json.decode(content);