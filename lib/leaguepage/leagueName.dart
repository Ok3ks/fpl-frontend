import 'package:flutter/material.dart';

import '../themes.dart';

class leagueName extends StatelessWidget {
  Map<String, dynamic>? data;
  bool hydrate;

  leagueName({super.key, required this.data, this.hydrate = true});

  @override
  Widget build(BuildContext context) {
    // String  name = data['leagueWeeklyReport']['leagueName'];
    if (hydrate == true) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MaterialTheme.darkMediumContrastScheme().onSurface,
              Colors.grey.shade100
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
              color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
              width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "${data?['leagueWeeklyReport']['leagueName']}",
          style: TextStyle(
            // Replace 'Stenciled' with a custom stencil or display font available in your assets or fonts
            fontFamily: 'Stenciled',
            color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
            fontWeight: FontWeight.w400,
            fontSize: 28,
            letterSpacing: 2,
            decoration: TextDecoration.none,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 4,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      );
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
