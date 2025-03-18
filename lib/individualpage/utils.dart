
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/themes.dart';

import '../types.dart';

class captainViceCaptainName extends ConsumerWidget {
  String playerName;
  double playerPoint;
  bool flag;

  captainViceCaptainName({
    super.key,
    required this.playerName,
    required this.playerPoint,
    required this.flag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      TextButton(
        child: Text(playerName.split(" ").last,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: flag
                    ? MaterialTheme.lightHighContrastScheme().onErrorContainer
                    : MaterialTheme.lightHighContrastScheme().onSurface,
                fontSize: 10)),
        onPressed: () {},
      ),
      TextButton(
        child: Text("$playerPoint",
            style: TextStyle(
                color: flag
                    ? MaterialTheme.lightHighContrastScheme().onErrorContainer
                    : MaterialTheme.lightHighContrastScheme().onSurface,
                fontSize: 12)),
        onPressed: () {},
      ),
    ]));
  }
}

String? parseParticipantIdFromUrl(String url) {
  try {
    final uri = Uri.parse(url); // Parse the URL to handle it more reliably
    final RegExp regExp = RegExp(r'entry/(\d+)/event/(\d+)');
    final match = regExp.firstMatch(uri.path);

    if (match != null && match.groupCount >= 1) {
      return match.group(1); // group(1) will contain the participant code
    }
    return null; // Return null if no league code is found
  } on FormatException {
    // Handle invalid URL
    return null;
  }
}

class participantIDWidget extends StatelessWidget {
  User? currParticipant;
  participantIDWidget({super.key, required this.currParticipant});

  @override
  Widget build(BuildContext context) {
    //TODO:Limit based on current gameweek
    return SizedBox(
      height: 30,
      width: 180,
      child: Card(
        color: const Color.fromRGBO(100, 100, 100, 0),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0,
                color:
                    MaterialTheme.darkMediumContrastScheme().primaryContainer),
            borderRadius: BorderRadius.circular(4)),
        child: SizedBox(
            // width: 80,
            // height: 50,
            child: Center(
          child: Text("Participant ID : ${currParticipant?.fplUrl}",
              style: TextStyle(
                  color: MaterialTheme.darkMediumContrastScheme().onSurface,
                  fontSize: 15)),
        )),
      ),
    );
  }
}
