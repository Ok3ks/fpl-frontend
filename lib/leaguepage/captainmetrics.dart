import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/themes.dart';

class CaptainMetrics extends StatelessWidget {
  Map<String, dynamic>? data;

  CaptainMetrics({super.key, required this.data});
  final yourScrollController = ScrollController(
    onAttach: (position) {},
    onDetach: (position) {},
  );

  final double gap = 10;
  @override
  Widget build(BuildContext context) {
    final List<dynamic>? captain = data?['leagueWeeklyReport']['captain'];
    return SizedBox(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(
        height: 3,
      ),
        if (captain != null)
        Card(
          color: MaterialTheme.darkMediumContrastScheme().onSurface,
          elevation: 5,
          child: Scrollbar(
              thickness: 2,
              trackVisibility: true,
              controller: yourScrollController,
              radius: const Radius.circular(3),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(
              captain.length,
              (index) {
              return CaptainMetricsCard(
              data: data?['leagueWeeklyReport']['captain']
              [index]);
              }),
                  ))))
    ]));
    // ],
    // ),);
  }
}

class CaptainMetricsCard extends ConsumerWidget {
  // final String title;
  dynamic data;

  CaptainMetricsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.sizeOf(context);
    final gameweek = ref.watch(gameweekProvider);

    return Row(children: [
      SizedBox(
          width: 100,
          child: FutureBuilder(
              future: pullPlayerStats(data?['player'], gameweek),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var obj = snapshot.data;
                  return Card(
                      // shadowColor: MaterialTheme.darkMediumContrastScheme().primary,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.5,
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .primary),
                          borderRadius: BorderRadius.circular(18)),
                      color: MaterialTheme.darkMediumContrastScheme()
                          .primaryContainer,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  // "",
                                  "${obj?.data?['player']['info']['playerName'].toString().split(" ").last}",
                                  style: TextStyle(
                                      fontSize: 10,
                                      // fontWeight: FontWeight.bold,
                                      color: MaterialTheme
                                              .darkMediumContrastScheme()
                                          .onSurface),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${(obj?.data?['player']['gameweekScore']['totalPoints'] != null) ? obj.data['player']['gameweekScore']['totalPoints'] * 2 : null}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      // fontWeight: FontWeight.bold,
                                      color: MaterialTheme
                                              .darkMediumContrastScheme()
                                          .primary),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 4),
                                    Text(data?['count'].toString() ?? "null",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11,
                                        )),
                                    const SizedBox(width: 2),
                                    const Icon(
                                      Icons.people,
                                      size: 11,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ])));
                } else {
                  return const LinearProgressIndicator();
                }
              }))
    ]);
  }
}
