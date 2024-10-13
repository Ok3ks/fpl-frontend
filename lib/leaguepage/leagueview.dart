import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/themes.dart';
import 'package:fpl/utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'benchmetrics.dart';
import 'captainmetrics.dart';
import 'dart:convert';
import 'transfermetrics.dart';
import 'performancemetrics.dart';
import 'package:fpl/constants.dart';


class LeagueView extends ConsumerStatefulWidget {
  LeagueView({super.key,});

  @override
  ConsumerState<LeagueView> createState() => LeagueViewState();
}

class LeagueViewState extends ConsumerState<LeagueView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController leagueIdController = TextEditingController();

    Orientation orientation = MediaQuery.of(context).orientation;
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    print("width: $width");
    print("height: $height");

    if (orientation == Orientation.landscape) {
    return  Center(
        child: Text("Adjust your device into a portrait orientation",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30
        )));}
    //Left becomes top
    else {
      return
        Container(
            color: MaterialTheme.darkMediumContrastScheme().onSurface,
        child: SingleChildScrollView(child: Column(
          children: [
        SizedBox(
            width: width,
            //height: (height/3) - 30,
              child: Card(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 250,
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
                                    child: TextField(
                                      //keyboardType: TextInputType.number,
                                      controller: leagueIdController,
                                      // inputFormatters: <TextInputFormatter>[
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],
                                      // maxLength: 12,
                                      // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                      style: TextStyle(fontSize: 10, color: Colors.white),
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
                                  String? leagueId = parseLeagueCodeFromUrl(leagueIdController.text);
                                  ref.read(leagueProvider.notifier)
                                      .state = double.tryParse(leagueId ?? "0");
                                  if (leagueIdController.text.length > 1) { //TODO More data validation for league code, Also be able to parse link
                                    setState(() {});
                                  }
                                },
                              )
                            ]),
                        GameweekWidget()
                      ]
                  )),
            ),
        LeagueStatsView()
      ])));}
    }
  }



class LeagueStatsView extends ConsumerStatefulWidget {
  LeagueStatsView({super.key,});

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
    return Column(
      children: [ //TODO: Add leagueName,
        FutureBuilder(
        future: pullStats(leagueId, gameweek),
        builder: (context, snapshot) {
          var obj = snapshot.data;
          print(snapshot.connectionState);
          if (snapshot.hasData) {
            return LeagueStats(data: obj);
          } else if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const Text("No Data");
          }
        })]);}
    return LandingPage();

  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
          Icon(Icons.warning, color: Colors.yellow,),
          Text("This webpage is under construction, best served in portrait orientation", style: TextStyle(fontSize: 15, color: Colors.black),),]),
          SizedBox(height: 10),
          Text("Provide Information about this league.",  style: TextStyle(fontSize: 15, color: Colors.black),),
          SizedBox(height: 10),
          Text("Copy league link from official fantasy premier league page. ",  style: TextStyle(fontSize: 15, color: Colors.black),),
          SizedBox(height: 10),
          Text("Example - https://fantasy.premierleague.com/leagues/538731/standings/c", style: TextStyle(fontSize: 15, color: Colors.black),),
        ]);
  }
}

class LeagueStats extends StatelessWidget {

  QueryResult data;
  LeagueStats({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
   String? leagueName = data.data?['leagueWeeklyReport']['leagueName'];
    return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("League Name : $leagueName ",  style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
          // Container(
          //   color: MaterialTheme.darkMediumContrastScheme().onSurface,
          //   child:
            Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.data?['leagueWeeklyReport']['leagueAverage'] != null )
                    PerformanceMetrics(data: data),
                  if (data.data?['leagueWeeklyReport']['bestTransferIn'].length != null)
                    CaptainMetrics(data: data),
                  if (data.data?['leagueWeeklyReport']['mostBenched'].length != null)
                    BenchMetrics(data:data),
                  if (data.data?['leagueWeeklyReport']['captain'].length != null && data.data?['leagueWeeklyReport']['bestTransferIn'].length > 1)
                    TransferMetrics(data: data),

        if (data.data?['leagueWeeklyReport']['mostBenched'].length == null)
    Center(
    child:Container(
      // color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
      color: Colors.white,
      child:

      Column(
        children: [
          const Text("Input is invalid", style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w200,
        color:
        Colors.red)),
        LandingPage(),
        ])
    ))])
    // ),
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
                  Text(title, style: TextStyle(color: Colors.white, fontSize: 11)),
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
