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

class LeagueView extends ConsumerStatefulWidget {
  LeagueView({
    super.key,
  });

  League? userLeague;

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

    final currParticipant = ref.watch(currentUserProvider);

    return SingleChildScrollView(
        child: Column(children: [
      Stack(alignment: AlignmentDirectional.center, children: [
        Image.asset(
          "assets/images/pexels-mike-1171084.webp",
          // width: 1474/3,
          // height: 534/3
        ),
        SizedBox(
            // width: 1474,
            // height: 500,
            // child: Card(
            child: Column(children: [
          // const SizedBox(height: 20),
          // if ( width > 300)
          // LandingPageTitle(),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (width > 300)
              SizedBox(
                  width: 200,
                  height: 40,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.5,
                            color: MaterialTheme.darkMediumContrastScheme()
                                .primary),
                        borderRadius: BorderRadius.circular(12)),
                    color: const Color.fromRGBO(100, 100, 100, 0),
                    child: TextField(
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                      cursorColor:
                          MaterialTheme.darkMediumContrastScheme().primary,
                      controller: leagueIdController,
                      // textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          hintText: 'Provide your FPL league URL',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w100,
                              fontStyle: FontStyle.italic),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      MaterialTheme.darkMediumContrastScheme()
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
            if (width > 300)
              IconButton(
                icon: Icon(Icons.keyboard_return,
                    color: MaterialTheme.darkMediumContrastScheme().primary),
                onPressed: () async {
                  if (leagueIdController.text.length > 1 &&
                      parseLeagueCodeFromUrl(leagueIdController.text) != '0') {
                    setState(() {
                      widget.userLeague = League(
                          leagueId: double.tryParse(
                              parseLeagueCodeFromUrl(leagueIdController.text)));
                      // parseLeagueCodeFromUrl(leagueIdController.text);
                    });
                  }

                  ref.read(leagueProvider.notifier).state = widget.userLeague;
                  final leagueId = ref.watch(leagueProvider);
                  if (leagueId != 0 &&
                      leagueId != null &&
                      currParticipant != null) {
                    await currParticipant.addLeague(leagueId);
                  }
                },
              )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.cen,
            children: [
              if (widget.userLeague != null) const leagueIDWidget(),
              if (width > 300) const GameweekWidget(),
            ],
          ),
          const expandedGameweekWidget()
        ])
            // )
            ),
      ]),
      const LeagueStatsView()
    ]));
    // );
  }
}
// }

class LeagueStatsView extends ConsumerStatefulWidget {
  const LeagueStatsView({
    super.key,
  });

  @override
  ConsumerState<LeagueStatsView> createState() => LeagueStatsViewState();
}

class LeagueStatsViewState extends ConsumerState<LeagueStatsView> {
  String? leagueName;

  @override
  Widget build(BuildContext context) {
    final leagueId = ref.watch(leagueProvider)?.leagueId;
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
                return LeagueStats(data: obj, hydrate: false);
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
  const LandingPageTitle({super.key});

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

  LandingPage({super.key});
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
                  title: const Text('Frequently Asked Questions'),
                  initiallyExpanded: true,
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  controller: expansionTileController,
                  childrenPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  maintainState: true,
                  iconColor: MaterialTheme.darkMediumContrastScheme().primary,
                  children: [
                    ExpansionTile(
                      leading: const Icon(Icons.sports_soccer),
                      iconColor:
                          MaterialTheme.darkMediumContrastScheme().primary,
                      collapsedIconColor:
                          MaterialTheme.darkMediumContrastScheme().primary,
                      title: const Text('What is this?'),
                      childrenPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      children: const [
                        Text(
                          "FplWrapped is a web-based application for fantasy premier league participants. "
                          "This application augments the official premier league application by providing league performance statistics on a weekly basis. "
                          "With this application, you can track performance of your local leagues in one view.",
                          style: TextStyle(fontSize: 13),
                          textAlign: TextAlign.justify,
                          textWidthBasis: TextWidthBasis.longestLine,
                        )
                      ],
                    ),
                    ExpansionTile(
                        leading: const Icon(Icons.sports_soccer),
                        iconColor:
                            MaterialTheme.darkMediumContrastScheme().primary,
                        collapsedIconColor:
                            MaterialTheme.darkMediumContrastScheme().primary,
                        childrenPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        maintainState: true,
                        title: const Text('How can i find my FPL league URL'),
                        children: [
                          Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  " 1] From the official Fantasy Premier league page, navigate to classic league of interest.",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                  textWidthBasis: TextWidthBasis.longestLine,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Image.asset(
                                    "assets/images/useApp - Step 1.png"),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  " 2]  Copy the https link in the URL bar of your browser after you must have clicked on the league of interest.",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                  textWidthBasis: TextWidthBasis.longestLine,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Image.asset(
                                    "assets/images/useApp - Step 2.png"),
                                Image.asset(
                                    "assets/images/useApp - Step 3.png"),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  " 3] Return to this page and past the copied link in the rectangular box",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                  textWidthBasis: TextWidthBasis.longestLine,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Image.asset(
                                    "assets/images/useApp - Step 4.png"),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Now you have a mini league report to view.",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                    ))
                              ]),
                        ]),
                    ExpansionTile(
                        leading: const Icon(Icons.sports_soccer),
                        iconColor:
                            MaterialTheme.darkMediumContrastScheme().primary,
                        collapsedIconColor:
                            MaterialTheme.darkMediumContrastScheme().primary,
                        title:
                            const Text('What should we expect in the future?'),
                        children: const []),
                  ]),
            ],
          ),
        ]));
  }
}

class LeagueStats extends StatelessWidget {
  Map<String, dynamic>? data;
  bool hydrate = true;

  LeagueStats({super.key, required this.data, this.hydrate = true});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        color: MaterialTheme.darkMediumContrastScheme().onSurface,
        child: SizedBox(
            child: Column(children: [
          leagueName(
            data: data,
            hydrate: hydrate,
          ),
          const CustomDivider(),
          const Text("League Stats"),
          PerformanceMetrics(data: data),
          const Text("Captain Stats"),
          CaptainMetrics(data: data),
          const CustomDivider(),
          BenchMetrics(data: data),
          SizedBox(width: 300, child: Differentials(data: data)),
          const CustomDivider(),
          TransferMetrics(data: data, hydrate: hydrate),
          if (data == null) //ToDo Add timeout here or just validate from entry?
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
        ])),
      )
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
              child: const Text("Man")),
          // const TextField(autocorrect: false, cursorHeight: 5,)),
          IconButton(
            icon: const Icon(Icons.keyboard_return),
            iconSize: 5,
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
                  Text(title, style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 7.5),
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
                      style:
                          const TextStyle(color: Colors.white, fontSize: 11)),
                  const SizedBox(height: 7.5),
                  Text(
                    data.toString(),
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
                  Text(title, style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 7.5),
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
