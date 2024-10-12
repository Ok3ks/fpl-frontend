import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/themes.dart';

class CaptainMetrics extends StatelessWidget {

  dynamic data;

  CaptainMetrics({super.key, required this.data});
  final yourScrollController =
  ScrollController(
    onAttach:(position) {

    } ,
    onDetach:(position) {

    },
  );


  final double gap = 10;
  @override
  Widget build(BuildContext context) {

    // final Size size = MediaQuery.sizeOf(context);
    // final double width = size.width * 2 / 3;
    // final double height = size.height;
    return SizedBox(
        child: Card(
            color: MaterialTheme.darkMediumContrastScheme().onSurface,
            elevation: 2,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Captain Points",
                          style:  TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold)),
                      IconButton(
                          onPressed: () {},
                          icon: Transform.rotate(
                              angle: 55,
                              child: const Icon(Icons.expand_circle_down_outlined,
                                  size: 18))),],
                  ),
                  //if (width > 500) : //Switch to list view
            Scrollbar(
                thickness: 2,
                trackVisibility: true,
                controller: yourScrollController,
                radius: const Radius.circular(3),
                  child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(data?.data?['leagueWeeklyReport']['captain'].length, (index) {
                    return CaptainMetricsCard(
                        data: data
                            ?.data?['leagueWeeklyReport']['captain'][index]);}
                  ),)))])));
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
          width: 150,
          height: 100,
          child:
          FutureBuilder(
            future: pullPlayerStats(data?['player'], gameweek),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var obj = snapshot.data;
                return Card(
                  // shadowColor: MaterialTheme.darkMediumContrastScheme().primary,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.5,
                            color: MaterialTheme
                                .darkMediumContrastScheme()
                                .primary),
                        borderRadius: BorderRadius.circular(18)),
                    color: MaterialTheme
                        .darkMediumContrastScheme()
                        .primaryContainer,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  textBaseline: TextBaseline.ideographic
                                  ,
                                  children:
                                [Text(
                                  "${
                                      (obj?.data?['player']['gameweekScore']['totalPoints'] != null)
                                      ?
                                  obj.data['player']['gameweekScore']['totalPoints'] * 2
                                      : null}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      // fontWeight: FontWeight.bold,
                                      color:
                                      MaterialTheme
                                          .darkMediumContrastScheme()
                                          .primary),
                                ),
                                // Text("pts", style: TextStyle(fontSize: 10, color: MaterialTheme
                                //           .darkMediumContrastScheme()
                                //           .primary),)
                                ]),
                                // const SizedBox(width: 6),
                              ]),
                          // SizedBox(height: 7.5),
                          Text(
                            // "",
                            "${obj?.data?['player']['info']['playerName']}",
                            style: TextStyle(
                                fontSize: 10,
                                // fontWeight: FontWeight.bold,
                                color:
                                MaterialTheme
                                    .darkMediumContrastScheme()
                                    .onSurface),
                          ),
                          // Row(
                          //   children:
                          // [
                            Text("Captained by ${data?['count'].toString() ?? "null"}", style:  TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme().primary,
                                fontSize: 11)),
                          // Align(
                          //     alignment: Alignment.bottomRight,
                          //     child: Text(
                          //         data?['count'].toString() ?? "null",
                          //         style: TextStyle(
                          //             fontSize: 10,
                          //             // fontWeight: FontWeight.bold,
                          //             color:
                          //             MaterialTheme
                          //                 .darkMediumContrastScheme()
                          //                 .primary)))])
                        ],
                      ),
                    ));

              }
              else {
                return const LinearProgressIndicator();
              }
            }
  )
      )]);
  }
}