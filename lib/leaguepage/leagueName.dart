import 'package:flutter/material.dart';
import 'package:fpl/themes.dart';

class leagueName extends StatelessWidget {
  Map<String, dynamic>? data;
  bool hydrate;

  leagueName({super.key, required this.data, this.hydrate = true});

  @override
  Widget build(BuildContext context) {
    // String  name = data['leagueWeeklyReport']['leagueName'];
    if (hydrate == true) {
      return Text("${data?['leagueWeeklyReport']['leagueName']}",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            decoration: TextDecoration.none,
          ));
    } else {
      //typing animation
      return const Text("typing..",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            decoration: TextDecoration.none,
          ));
    }
  }
}
