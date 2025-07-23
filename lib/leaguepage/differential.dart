import 'package:flutter/material.dart';
import 'package:fpl/themes.dart';
import 'package:fpl/utils.dart';

class Differentials extends StatelessWidget {
  Map<String, dynamic>? data;

  Differentials({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    List<Object?>? players =
        data?['leagueWeeklyReport']['differential']['players'];

    //ToDo: add entryId to graphqlschema, need to update django backend. Maybe Version and aggregate all changes

    return Column(children: [
      SizedBox(
          child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.5,
                color: MaterialTheme.darkMediumContrastScheme().primary),
            borderRadius: BorderRadius.circular(18)),
        color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 3),
                  Center(
                      child: Text("Differentials of the Week",
                          style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
                                  .onSurface,
                              fontSize: 10))),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(players?.length ?? 0, (index) {
                        return playerName(
                            playerId:
                                int.parse(players?[index].toString() ?? "0") ??
                                    0);
                      })),
                  // playerPoints(index: index, benchData:teams);}
                  // )),
                  const SizedBox(height: 5)
                ])),
      ))
    ]);
    // ]);
  }
}
