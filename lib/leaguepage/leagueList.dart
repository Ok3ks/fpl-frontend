import 'package:fpl/utils.dart';

import '../dataprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/themes.dart';

import '../types.dart';

class LeagueList extends ConsumerStatefulWidget {
  double width;
  LeagueList({
    super.key,
    required this.width,
  });

  @override
  ConsumerState<LeagueList> createState() => LeagueListState();
}

class LeagueListState extends ConsumerState<LeagueList> {
  LeagueListState({required});

  @override
  Widget build(BuildContext context) {
    final currUser = ref.watch(currentUserProvider);
    final Size size = MediaQuery.sizeOf(context);

    return FutureBuilder(
        future: getParticipantLeagues(currUser?.participantId),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<League>? leagues = snapshot.data;
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(leagues?.length ?? 1, (index) {
              return SizedBox(
                  width: widget.width,
                  child: Card(
                      margin: const EdgeInsetsGeometry.fromLTRB(7, 10, 7, 0),
                      elevation: 8,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: TextButton(
                        onPressed: () {
                          ref.read(leagueProvider.notifier).state =
                              leagues?[index];

                          //   setState(() {
                          //     widget.userLeague = League(
                          //         leagueId: double.tryParse(
                          //             parseLeagueCodeFromUrl(
                          //                 leagueIdController.text, false)));
                          //     // parseLeagueCodeFromUrl(leagueIdController.text);
                          //   });
                        },
                        child: Text(leagues?[index].name ?? "No name",
                            textDirection: TextDirection.rtl,
                            softWrap: true,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 9,
                            )),
                      )));
            }));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Snapshot Connecting");
          } else {
            return const Text("Handle final state");
          }
        });
  }
}
