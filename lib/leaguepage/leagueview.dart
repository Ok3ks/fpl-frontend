import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/themes.dart';
import 'package:fpl/utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:fpl/leaguepage/benchmetrics.dart';
import 'package:fpl/leaguepage/captainmetrics.dart';
import 'package:fpl/leaguepage/transfermetrics.dart';
import 'package:fpl/leaguepage/performancemetrics.dart';

import 'dart:convert';
import 'package:fpl/auth.dart';

class LeagueView extends ConsumerStatefulWidget {
  LeagueView({
    super.key,
  });

  String? leagueId;

  @override
  ConsumerState<LeagueView> createState() => LeagueViewState();
}

class LeagueViewState extends ConsumerState<LeagueView> {
  TextEditingController leagueIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    if (orientation == Orientation.landscape) {
      return Center(
          child: Text("Adjust your device into a portrait orientation",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)));
    }
    //Left becomes top
    else {
      return SingleChildScrollView(
          child: Column(children: [
        Stack(alignment: AlignmentDirectional.center, children: [
          Image.asset("assets/images/pexels-mike-1171084.webp"),
          SizedBox(
              width: width,
              //height: (height/3) - 30,
              // child: Card(
              child: Column(children: [
                const SizedBox(height: 20),
                LandingPageTitle(),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                      width: 250,
                      height: 50,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.5,
                                color: MaterialTheme.darkMediumContrastScheme()
                                    .primary),
                            borderRadius: BorderRadius.circular(12)),
                        color: Color.fromRGBO(100, 100, 100, 0),
                        child: TextField(

                          style: TextStyle(fontSize: 10, color: Colors.white),
                          cursorColor:
                              MaterialTheme.darkMediumContrastScheme().primary,
                          controller: leagueIdController,
                          // textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              hintText: 'Provide your FPL league URL',
                              hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                  fontStyle: FontStyle.italic),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MaterialTheme
                                              .darkMediumContrastScheme()
                                          .primaryContainer)),
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          MaterialTheme.darkMediumContrastScheme()
                                              .primaryContainer)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          MaterialTheme.darkMediumContrastScheme()
                                              .primaryContainer)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          MaterialTheme.darkMediumContrastScheme()
                                              .primaryContainer)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              fillColor: Colors.white,
                              iconColor: Colors.white),
                          cursorHeight: 20,
                          autocorrect: false,
                        ),
                      )),
                  // ),
                  IconButton(
                    icon: Icon(Icons.keyboard_return,
                        color:
                            MaterialTheme.darkMediumContrastScheme().primary),
                    onPressed: () async {
                      widget.leagueId =
                          parseLeagueCodeFromUrl(leagueIdController.text);
                      ref.read(leagueProvider.notifier).state =
                          double.tryParse(widget.leagueId ?? "0");
                      if (leagueIdController.text.length > 1) {
                        //TODO More data validation for league code, Also be able to parse link
                        setState(() {
                          widget.leagueId =
                              parseLeagueCodeFromUrl(leagueIdController.text);
                        });
                      }
                    },
                  )
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.cen,
                  children: [
                    if (widget.leagueId != null) leagueIDWidget(),
                    GameweekWidget()
                  ],
                ),
              ])
              // )
              ),
        ]),
        LeagueStatsView()
      ]));
      // );
    }
  }
}

class LeagueStatsView extends ConsumerStatefulWidget {
  LeagueStatsView({
    super.key,
  });

  @override
  ConsumerState<LeagueStatsView> createState() => LeagueStatsViewState();
}

class LeagueStatsViewState extends ConsumerState<LeagueStatsView> {
  String? leagueName;

  @override
  Widget build(BuildContext context) {
    final leagueId = ref.watch(leagueProvider);
    final gameweek = ref.watch(gameweekProvider);

    if (leagueId != null) {
      return Column(children: [
        //TODO: Add leagueName,
        FutureBuilder(
            future: pullStats(leagueId, gameweek),
            builder: (context, snapshot) {
              var obj = snapshot.data;
              print(snapshot.connectionState);
              if (snapshot.hasData) {
                return LeagueStats(data: obj);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return const Text("No Data");
              }
            })
      ]);
    }
    return LandingPage();
  }
}

class LandingPageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "MINI  LEAGUE  REPORT",
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  ExpansionTileController expansionTileController = ExpansionTileController();
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Column(
            children: [
              ExpansionTile(
                title: Text('Frequently Asked Questions'),
                initiallyExpanded: true,
                backgroundColor: Colors.white,
                collapsedBackgroundColor: Colors.white,
                controller: expansionTileController,
                childrenPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                maintainState: true,
                iconColor: MaterialTheme.darkMediumContrastScheme().primary,
                children: [
                   ExpansionTile(
                    leading: Icon(Icons.sports_soccer),
                     iconColor: MaterialTheme.darkMediumContrastScheme().primary,
                    collapsedIconColor:  MaterialTheme.darkMediumContrastScheme().primary,
                    title: Text('What is this?'),
                     childrenPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),

                  children: [
                    Text(
                        "Dontsuckatfpl is a web-based application for fantasy premier league lovers. With this application, your leagues just got more competitive. The application offers users a closer look into the happenings in their local leagues.With this application, you can track not just your performances, but the overall performance of your local leagues in one view.",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.justify,
                      textWidthBasis: TextWidthBasis.longestLine,
                    )
                      ],),
              ExpansionTile(
                  leading: Icon(Icons.sports_soccer),
                  iconColor: MaterialTheme.darkMediumContrastScheme().primary,
                  collapsedIconColor:  MaterialTheme.darkMediumContrastScheme().primary,
                  childrenPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  maintainState: true,
                  title: Text('How can i find my FPL league URL'),
                  children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        " 1] From the official Fantasy Premier league page, navigate to classic league of interest.",
                        style: TextStyle(fontSize: 10,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                        textWidthBasis: TextWidthBasis.longestLine,),
                      SizedBox(height: 5,),
                      Image.asset("assets/images/useApp - Step 1.png"),
                      SizedBox(height: 5,),
                      const Text(
                        " 2]  Copy the https link in the URL bar of your browser after you must have clicked on the league of interest.",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                        textWidthBasis: TextWidthBasis.longestLine,),
                      SizedBox(height: 5,),
                      Image.asset("assets/images/useApp - Step 2.png"),
                      Image.asset("assets/images/useApp - Step 3.png"),
                      SizedBox(height: 5,),
                      const Text(
                        " 3] Return to this page and past the copied link in the rectangular box",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                        textWidthBasis: TextWidthBasis.longestLine,),
                      SizedBox(height: 5,),
                      Image.asset("assets/images/useApp - Step 4.png"),
                      SizedBox(height: 5,),
                      Align(
                          alignment: Alignment.center,
                          child:Text(
                        "Now you have a mini league report to view.",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        textWidthBasis: TextWidthBasis.longestLine,))

                    ]
    ),
                        ]),
                    ExpansionTile(
                        leading: Icon(Icons.sports_soccer),
                        iconColor:
                            MaterialTheme.darkMediumContrastScheme().primary,
                        collapsedIconColor:
                            MaterialTheme.darkMediumContrastScheme().primary,
                        title: Text('What should we expect in the future?'),
                        children: []),
                  ]),
            ],
          ),
        ]));
  }
}

class LeagueStats extends StatelessWidget {
  QueryResult data;
  LeagueStats({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String? leagueName = data.data?['leagueWeeklyReport']['leagueName'];
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text("$leagueName ",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            decoration: TextDecoration.none,
          )),

      Container(
        color: MaterialTheme.darkMediumContrastScheme().onSurface,
        child:
      Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.data?['leagueWeeklyReport']['leagueAverage'] != null)
              PerformanceMetrics(data: data),
            if (data.data?['leagueWeeklyReport']['bestTransferIn'].length !=
                null)
              CaptainMetrics(data: data),
            if (data.data?['leagueWeeklyReport']['mostBenched'].length != null)
              BenchMetrics(data: data),
            if (data.data?['leagueWeeklyReport']['captain'].length != null &&
                data.data?['leagueWeeklyReport']['bestTransferIn'].length > 1)
              TransferMetrics(data: data),
            if (data.data?['leagueWeeklyReport']['mostBenched'].length == null)
              Center(
                  child: Container(
                      // color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
                      color: Colors.white,
                      child: Column(children: [
                        const Text("Input is invalid",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: Colors.red)),
                        LandingPage(),
                      ])))
          ])
      ),
    ]);
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
              child: Text("Man")),
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
        width: 150,
        height: 100,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(color: Colors.white, fontSize: 11)),
                  SizedBox(height: 7.5),
                  Text(
                    "${data.toString()}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color:
                            MaterialTheme.darkMediumContrastScheme().primary),
                  ),
                ],
              ),
            )),
      )
    ]);
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
