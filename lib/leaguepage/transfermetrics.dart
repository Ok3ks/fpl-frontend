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
            const Center(
                child: Text("Transfer Impact",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ))),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(1, (index) {
                  return Row(children: [
                    TransferOut(
                      data: widget.data?['leagueWeeklyReport']
                          ['mostTransferredOut'],
                      index: index,
                    ),
                    TransferIn(
                      data: widget.data?['leagueWeeklyReport']
                          ['mostTransferredIn'],
                      index: index,
                    )
                  ]);
                })),
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
        // width: 600,
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
                          child: TextButton(
                        child: Text("${data[index]['teamName']}",
                            style: TextStyle(
                              color: MaterialTheme.darkMediumContrastScheme()
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
                              child: Column(children: [
                        Text(
                          "${data[index]['pointsDelta']}pts",
                          style: TextStyle(
                              color: data[index]['pointsDelta'] > 0
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        if (data[index]['pointHit'] > 0)
                          Text(
                            "( - ${data[index]['pointHit'] ?? 0}pts )",
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w200,
                                fontSize: 10),
                          ),
                      ])))
                    ]))));
  }
}

class TransferOut extends StatelessWidget {
  dynamic data;
  int index;

  TransferOut({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    //TODO: Find an elegant way
    List<dynamic> playerOutIds = data ?? [];
    print("---transfer out");
    print(playerOutIds);

    return SizedBox(
        width: 200,
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
                      Row(children: [
                        Text("${playerOutIds[index]?['out'] ?? 0}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        Icon(
                          Icons.people,
                          color: Colors.white,
                        ),
                      ]),
                      Icon(
                        Icons.arrow_circle_right_sharp,
                        color: Colors.red,
                      ),
                      if (playerOutIds.isNotEmpty)
                        playerName(
                          playerId: int.parse(
                              playerOutIds[index]?['player'].toString() ?? "0"),
                          vertical: false,
                        ),
                    ]))));
  }
}

class TransferIn extends StatelessWidget {
  dynamic data;
  int index;

  TransferIn({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    //TODO: Find an elegant way
    List<dynamic> playerInIds = data ?? [];

    return SizedBox(
        width: 200,
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
                      Row(children: [
                        Text("${playerInIds[index]?['in']}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12)),
                        const Icon(
                          Icons.people,
                          color: Colors.white,
                        ),
                      ]),
                      const Icon(
                        Icons.arrow_circle_left_sharp,
                        color: Colors.green,
                      ),
                      if (playerInIds.isNotEmpty)
                        playerName(
                          playerId: int.parse(
                              playerInIds[index]?['player'].toString() ?? "0"),
                          vertical: false,
                        ),
                    ]))));
  }
}
