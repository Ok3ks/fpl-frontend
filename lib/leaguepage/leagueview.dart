import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/themes.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'benchmetrics.dart';

final leagueProvider = StateProvider<double?>((ref) {
  return null;
});

final gameweekProvider = StateProvider<double>((ref) {
  return 1;
});

class LeagueView extends ConsumerStatefulWidget {
  LeagueView({super.key,});

  @override
  ConsumerState<LeagueView> createState() => LeagueViewState();
}

class LeagueViewState extends ConsumerState<LeagueView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController leagueIdController = TextEditingController();

    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;
    String? leagueId;

    return Row(children: [
      SizedBox(
          width: (width / 3) - 30,
          height: height,
          child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
            SizedBox(
                width: 150,
                height: 50,
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.5,
                          color:
                              MaterialTheme.darkMediumContrastScheme().primary),
                      borderRadius: BorderRadius.circular(12)),
                  color:
                      MaterialTheme.darkMediumContrastScheme().primaryContainer,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: leagueIdController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLength: 12,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    cursorColor:
                        MaterialTheme.darkMediumContrastScheme().primary,
                    // textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .primaryContainer)),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .primaryContainer)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .primaryContainer)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .primaryContainer)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                        fillColor: Colors.white,
                        iconColor: Colors.white),
                    cursorHeight: 20,
                    autocorrect: false,
                  ),
                )),
            IconButton(
              icon: Icon(Icons.keyboard_return,
                  color: MaterialTheme.darkMediumContrastScheme().primary),
              onPressed: () async {
                ref.read(leagueProvider.notifier)
                    .state = double.tryParse(leagueIdController.text);
                if (leagueIdController.text.length > 1) { //TODO More data validation for league code, Also be able to parse link
                  setState(() {});
                }
              },
            )
          ]))),
        LeagueStatsView()
    ]);
  }
}

class LeagueStatsView extends ConsumerStatefulWidget {
  LeagueStatsView({super.key,});

  @override
  ConsumerState<LeagueStatsView> createState() => LeagueStatsViewState();
}

class LeagueStatsViewState extends ConsumerState<LeagueStatsView> {

  @override
  Widget build(BuildContext context) {
    final leagueId = ref.watch(leagueProvider);
    final gameweek = ref.watch(gameweekProvider);

    print(leagueId);

    if (leagueId != null) {
    return FutureBuilder(
        future: pullStats(leagueId, gameweek),
        builder: (context, snapshot) {
          var obj = snapshot.data;
          if (snapshot.hasData) {
            return LeagueStats(data: obj);
          } else if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const Text("No Data");
          }

        });}
    return const Text("Provide Information about this league", style: TextStyle(fontSize: 15),);
  }
}

class LeagueStats extends StatelessWidget {
  QueryResult data;
  LeagueStats({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    print(data.data?['leagueWeeklyReport']);

    return SingleChildScrollView(
        child: Container(
            color: MaterialTheme.darkMediumContrastScheme().onSurface,
            child: Column(children: [
              AMetrics(data: data),
              // PointsMetrics(title: "Points"),
              // LeagueAverageCard(title: "league_Average", data: leagueAverage),
              CaptainMetrics(data: data),
              if (data.data?['leagueWeeklyReport']['bestTransferIn'].length >=1)
              Column(children: [
                const Text("Transfer Impact",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),

                TransferMetrics(data: data)
              ]),

              Column(children: [
                const Text("Bench Effect",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
                BenchMetrics(data:data)
              ]),
            ])));
  }
}

class ChooseLeague extends StatelessWidget {
  const ChooseLeague({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    return SizedBox(
        width: width / 3,
        height: height,
        child: Card(
            child: Row(children: [
          Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.5,
                      color: MaterialTheme.darkMediumContrastScheme().primary),
                  borderRadius: BorderRadius.circular(18)),
              color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
              child: Text("mAn")),
          // const TextField(autocorrect: false, cursorHeight: 5,)),
          IconButton(
            icon: Icon(Icons.keyboard_return),
            onPressed: () {},
          )
        ])));
    //Icon button onPressed, then change the value of the future provider
    //graphql response, which is pullStats
  }
}



class AMetrics extends StatelessWidget {
  dynamic data;
  AMetrics({super.key, required this.data});

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
            shadowColor:
                MaterialTheme.darkMediumContrastScheme().secondaryContainer,
            color: MaterialTheme.darkMediumContrastScheme().onSurface,
            //elevation: 0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Performance",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              //if (width > 500) : //Switch to list view
              SizedBox(height: 20),
              Center(child: Text("----Chart of rank rise and drop---")),
              Row(children: [
                MetricsCard(
                    title: "Exceptional ",
                    data: data.data?['leagueWeeklyReport']['exceptional']
                        ['score']),
                MetricsCard(
                    title: "League Average",
                    data: data.data?['leagueWeeklyReport']['leagueAverage']
                        .ceilToDouble()
                        .toString()),
                if (data.data?['leagueWeeklyReport']['abysmal']['score'] !=
                    null)
                  MetricsCard(
                      title: "Abysmal ",
                      data: data.data?['leagueWeeklyReport']['abysmal']
                          ['score']),
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

class CaptainMetrics extends StatelessWidget {
  dynamic data;
  CaptainMetrics({super.key, required this.data});

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
              Text("Captain Points",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              //if (width > 500) : //Switch to list view
              Row(children: [
                MetricsCard(
                    title: "Differential Captain",
                    data: data
                        .data?['leagueWeeklyReport']['captain'].first['count']),
                MetricsCard(
                    title: "Most Captained",
                    data: data
                        .data?['leagueWeeklyReport']['captain'].last['count']),
                // MetricsCard(title: "Bench/Auto-sub", data: data.data?['leagueWeeklyReport']['captain'][0]['player'])
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


class LeagueAverageCard extends StatelessWidget {
  final String title;
  double data;

  LeagueAverageCard({super.key, required this.title, required this.data});

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
                  Center(
                      child: Text(
                    "${data.ceilToDouble()}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color:
                            MaterialTheme.darkMediumContrastScheme().primary),
                  )),
                  Text(
                    "Comments",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color:
                            MaterialTheme.darkMediumContrastScheme().onSurface),
                  ),
                ],
              ),
            )),
      )
    ]);
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
                    "${data.toString()}",
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
  dynamic data;
  TransferMetrics({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    List<String> transferImpactKeys = ["bestTransferIn", "worstTransferIn", ""];

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(2, (index) {
      return TransferTile(keys: transferImpactKeys[index], data: data);
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

Map<String, dynamic> loadFile(String jsonPath) {
  String jsonString =
      """ {"captain": {"328": 8, "401": 6, "351": 4, "317": 1}, "promoted_vice": [], "chips": {},
                           "exceptional": [["Hashira", 89]], "abysmal": [], "league_average": 67.84210526315789, "rise": [], "fall": [[19, 0, "Ayodeji Omoniyi"], [18, 0, "coker sunkanmi"], [17, 0, "Hassan Howlader"], [15, 0, "Martins Omoniyi"]], "most_transferred_out": [], "least_transferred_out": [], "most_transferred_in": [], "least_transferred_in": [], "best_transfer_in": [], "worst_transfer_in": [], "most_points_on_bench": [["Potters touch", {"Dean Henderson": 2, "Harry Winks": 2, "Jo\u0161ko Gvardiol": 7, "Wout Faes": 1}, 12], ["Just Chillin'", {"Mark Flekken": 4, "Rodrigo Muniz Carvalho": 2, "Antonee Robinson": 2, "Valent\u00edn Barco": 0}, 8], ["Sukeyinc", {"Robert S\u00e1nchez": 2, "Joachim Andersen": 0, "Ezri Konsa Ngoyo": 2,
                           "Harry Winks": 2}, 6]], "jammy_points": [["Bulldozers FC", ["Antonee Robinson", "Wout Faes"],
                          ["Kyle Walker", "Valent\u00edn Barco"], 3], ["Potters touch", [], [], 0], ["the eye test", [], [], 0]]} """;
  // Parse JSON string into a Map
  final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  return jsonMap;
}

Map<String, dynamic> values = loadFile("jsonPath");
//List<dynamic> fixtureRows = json.decode(content);
