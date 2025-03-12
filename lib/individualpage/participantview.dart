import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:fpl/dataprovider.dart';
import 'package:fpl/themes.dart';
import 'package:fpl/individualpage/utils.dart';

//TODO: Add user avatar box to page, to indicate a user is loggedIn
//TODO: Adjust Wording

class ParticipantView extends ConsumerStatefulWidget {
  ParticipantView({
    super.key,
  });

  String? participantId;

  @override
  ConsumerState<ParticipantView> createState() => ParticipantViewState();
}

class ParticipantViewState extends ConsumerState<ParticipantView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController participantIdController = TextEditingController();

    Orientation orientation = MediaQuery.of(context).orientation;
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    print("width: $width");
    print("height: $height");

    final currParticipant = ref.watch(currentUserProvider);
    participantIdController.text = currParticipant?.fplUrl ?? "null";

    if (orientation == Orientation.landscape) {
      return const Center(
          child: const Text("Adjust your device into a portrait orientation",
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
                          controller: participantIdController,
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                          cursorColor:
                              MaterialTheme.darkMediumContrastScheme().primary,
                          // textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              hintText: "Provide your FPL team URL",
                              hintStyle: const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 80),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MaterialTheme.darkMediumContrastScheme()
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
                      widget.participantId = parseParticipantIdFromUrl(
                          participantIdController.text);

                      if (participantIdController.text.length > 1) {
                        //TODO More data validation for league code, Also be able to parse link
                        setState(() {
                          widget.participantId = parseParticipantIdFromUrl(
                              participantIdController.text);
                        });
                      }
                    },
                  )
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.cen,
                  children: [
                    if (widget.participantId != null) participantIDWidget(),
                  ],
                ),
              ])
              // )
              ),
        ]),
        ParticipantStatsView()
      ]));
      // );
    }
  }
}

class ParticipantStatsView extends ConsumerStatefulWidget {
  ParticipantStatsView({
    super.key,
  });

  @override
  ConsumerState<ParticipantStatsView> createState() =>
      ParticipantStatsViewState();
}

class ParticipantStatsViewState extends ConsumerState<ParticipantStatsView> {
  String? leagueName;

  @override
  Widget build(BuildContext context) {
    final currParticipant = ref.watch(currentUserProvider);

    if (currParticipant?.fplUrl != null) {
      return Column(children: [
        FutureBuilder(
            future: pullParticipantStats(double.tryParse(currParticipant?.fplUrl ?? "")),
            builder: (context, snapshot) {
              var obj = snapshot.data;
              if (snapshot.hasData) {
                return ParticipantStats(data: obj);
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

class ParticipantStats extends StatelessWidget {
  QueryResult data;
  ParticipantStats({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<Object?> gameweek = data.data?['participantReport']['gw'];
    List<Object?> totalPoints = data.data?['participantReport']['totalPoints'];
    dynamic captain = data.data?['participantReport']['captain'];
    dynamic viceCaptain = data.data?['participantReport']['viceCaptain'];
    List<Object?> captainPoints =
        data.data?['participantReport']['captainPoints'];
    List<Object?> viceCaptainPoints =
        data.data?['participantReport']['viceCaptainPoints'];
    List<Object?> activeChip = data.data?['participantReport']['activeChip'];
    dynamic highestScoringPlayer =
        data.data?['participantReport']['highestScoringPlayer'];
    List<Object?> highestScoringPlayerPoints =
        data.data?['participantReport']['highestScoringPlayerPoints'];
    List<List<Object?>> interest = [
      gameweek,
      totalPoints,
      captainPoints,
      viceCaptainPoints,
      highestScoringPlayer
    ];

    return DataTable(
        columns: const [
          DataColumn(label: Text("GW")),
          DataColumn(label: Text("Points")),
          DataColumn(label: Text("Captain")),
          DataColumn(label: Text("Vice")),
          // DataColumn(label: Text("Event Transfer Cost")), //Maybe Transfers is better?
          DataColumn(label: Text("Highest Scoring Player")),
          //league average
        ],
        rows: List.generate(gameweek.length, (rowIndex) {
          var vcPoint =
              double.tryParse(viceCaptainPoints[rowIndex].toString()) ?? 0;
          var capPoint =
              double.tryParse(captainPoints[rowIndex].toString()) ?? 0;
          var hpPoints = double.tryParse(
                  highestScoringPlayerPoints[rowIndex].toString()) ??
              0;
          return DataRow(
              color: WidgetStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (vcPoint * 2 > capPoint) {
                  return MaterialTheme.darkMediumContrastScheme()
                      .error
                      .withOpacity(1.0);
                }
                return MaterialTheme.darkMediumContrastScheme()
                    .onSurface
                    .withOpacity(1.0); // Use the default value.
              }),
              cells: List.generate(interest.length, (cellIndex) {
                if (interest[cellIndex] == captainPoints) {
                  return DataCell(captainViceCaptainName(
                    playerName: captain[rowIndex]['info']['playerName'],
                    playerPoint: capPoint,
                  ));
                }
                if (interest[cellIndex] == viceCaptainPoints) {
                  return DataCell(captainViceCaptainName(
                      playerName: viceCaptain[rowIndex]['info']['playerName'],
                      playerPoint: vcPoint));
                }
                if (interest[cellIndex] == highestScoringPlayer) {
                  return DataCell(captainViceCaptainName(
                    playerName: highestScoringPlayer[rowIndex]['info']
                        ['playerName'],
                    playerPoint: hpPoints,
                  ));
                }
                if (interest[cellIndex] == totalPoints) {
                  return DataCell(Row(children: [
                    Text(interest[cellIndex][rowIndex].toString()),
                    if (activeChip[rowIndex] != null)
                      Text(
                        activeChip[rowIndex].toString(),
                        style: const TextStyle(
                            fontSize: 10, fontStyle: FontStyle.italic),
                      ),
                  ]));
                } else {
                  return DataCell(
                    Text("${interest[cellIndex][rowIndex].toString()}"),
                  );
                }
              }));
        }));
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
                  childrenPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  maintainState: true,
                  iconColor: MaterialTheme.darkMediumContrastScheme().primary,
                  children: [
                    ExpansionTile(
                      leading: Icon(Icons.sports_soccer),
                      iconColor:
                          MaterialTheme.darkMediumContrastScheme().primary,
                      collapsedIconColor:
                          MaterialTheme.darkMediumContrastScheme().primary,
                      title: Text('What is this?'),
                      childrenPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      children: [
                        Text(
                          "Dontsuckatfpl is a web-based application for fantasy premier league lovers. With this application, your leagues just got more competitive. The application offers users a closer look into the happenings in their local leagues.With this application, you can track not just your performances, but the overall performance of your local leagues in one view.",
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.justify,
                          textWidthBasis: TextWidthBasis.longestLine,
                        )
                      ],
                    ),
                    ExpansionTile(
                        leading: Icon(Icons.sports_soccer),
                        iconColor:
                            MaterialTheme.darkMediumContrastScheme().primary,
                        collapsedIconColor:
                            MaterialTheme.darkMediumContrastScheme().primary,
                        childrenPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        maintainState: true,
                        title: Text('How can i find my FPL league URL'),
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
                                SizedBox(
                                  height: 5,
                                ),
                                Image.asset(
                                    "assets/images/useApp - Step 1.png"),
                                SizedBox(
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
                                SizedBox(
                                  height: 5,
                                ),
                                Image.asset(
                                    "assets/images/useApp - Step 2.png"),
                                Image.asset(
                                    "assets/images/useApp - Step 3.png"),
                                SizedBox(
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
                                SizedBox(
                                  height: 5,
                                ),
                                Image.asset(
                                    "assets/images/useApp - Step 4.png"),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
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

class LandingPageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "PARTICIPANT REPORT",
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        decoration: TextDecoration.none,
      ),
    );
  }
}
