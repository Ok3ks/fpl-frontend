import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/themes.dart';
import '../utils.dart';
import 'dart:html' as html;
import '../dataprovider.dart';

class TransferMetrics extends StatefulWidget {
  // final String title;
  Map<String, dynamic>? data;
  bool hydrate;
  TransferMetrics({super.key, required this.data, this.hydrate = true});

  @override
  State<TransferMetrics> createState() => TransferMetricsState();
}

class TransferMetricsState extends State<TransferMetrics>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward()
          ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    bool hasItems =
        widget.data?['leagueWeeklyReport']['bestTransferIn'].length > 0;

    if (widget.hydrate && hasItems) {
      return SizedBox(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            const Text("Transfer Impact",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  decoration: TextDecoration.none,
                )),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(2, (index) {
                  return TransferTile(
                      data: widget.data?['leagueWeeklyReport']
                          ['bestTransferIn'],
                      index: index);
                })),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(2, (index) {
                  return TransferTile(
                      data: widget.data?['leagueWeeklyReport']
                          ['worstTransferIn'],
                      index: index);
                }))
          ]));
    } else {
      return SizedBox(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(2, (index) {
                  return SizedBox(
                      width: 600,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.5,
                                  color:
                                      MaterialTheme.darkMediumContrastScheme()
                                          .primary),
                              borderRadius: BorderRadius.circular(8)),
                          color: MaterialTheme.darkMediumContrastScheme()
                              .primaryContainer,
                          child: Opacity(
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: animation,
                              size: 10.0,
                            ),
                            opacity: 0.5,
                          )));
                })),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(2, (index) {
                  return SizedBox(
                      width: 600,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.5,
                                  color:
                                      MaterialTheme.darkMediumContrastScheme()
                                          .primary),
                              borderRadius: BorderRadius.circular(8)),
                          color: MaterialTheme.darkMediumContrastScheme()
                              .primaryContainer,
                          child: Opacity(
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: animation,
                              size: 10.0,
                            ),
                            opacity: 0.5,
                          )));
                }))
          ]));
    }
  }
}

class TransferTile extends ConsumerWidget {
  dynamic data;
  int index;

  TransferTile({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameweek = ref.watch(gameweekProvider);

    //TODO: Find an elegant way
    List<Object?> playerInIds = data[index]['playerIn'] ?? [];
    List<Object?> playerOutIds = data[index]['playerOut'] ?? [];

    return SizedBox(
        width: 600,
        child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    color: MaterialTheme.darkMediumContrastScheme().primary),
                borderRadius: BorderRadius.circular(8)),
            color: MaterialTheme.darkMediumContrastScheme().primaryContainer,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 100,
                          child: TextButton(
                            child: Text("${data[index]['teamName']}",
                                style: TextStyle(
                                  color:
                                      MaterialTheme.darkMediumContrastScheme()
                                          .primary,
                                  fontSize: 10,
                                )),
                            onPressed: () {
                              html.window.location.assign(
                                  "https://fantasy.premierleague.com/entry/${data[index]['entryId']}/event/$gameweek");
                            },
                          )),
                      if (playerOutIds.isNotEmpty)
                        Column(
                            children: List.generate(playerOutIds.length, (i) {
                          return playerName(
                            playerId:
                                int.parse(playerOutIds[i].toString() ?? "0"),
                            vertical: false,
                          );
                        })),
                      const SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.arrow_circle_right_sharp,
                                color: Colors.red,
                              ),
                              Icon(
                                Icons.arrow_circle_left_sharp,
                                color: Colors.green,
                              )
                            ],
                          )),
                      if (playerInIds.isNotEmpty)
                        Column(
                            children: List.generate(playerInIds.length, (i) {
                          return playerName(
                            playerId:
                                int.parse(playerInIds[i].toString() ?? "0"),
                            vertical: false,
                          );
                        })),
                      SizedBox(
                          child: Center(
                        child: Text(
                          "${data[index]['pointsDelta']}pts",
                          style: TextStyle(
                              color: data[index]['pointsDelta'] > 0
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                    ]))));
  }
}
