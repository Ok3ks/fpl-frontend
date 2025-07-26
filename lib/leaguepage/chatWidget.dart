import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:uuid/uuid.dart';
import 'package:fpl/themes.dart';
import 'package:fpl/types.dart';
import 'dart:convert';

import '../individualpage/participantview.dart';

class Chat extends ConsumerStatefulWidget {
  double chatBoxWidth;
  Chat({
    super.key,
    required this.chatBoxWidth,
  });

  @override
  ConsumerState<Chat> createState() => ChatState();
}

class ChatState extends ConsumerState<Chat> {
  @override
  Widget build(BuildContext context) {
    final leagueId = ref.watch(leagueProvider)?.leagueId;
    final gameweek = ref.watch(gameweekProvider);
    final currentUser = ref.watch(currentUserProvider);

    if (leagueId != null) {
      return Column(children: [
        FutureBuilder(
            future: pullStats(leagueId, gameweek),
            builder: (context, snapshot) {
              var obj = snapshot.data;
              print(snapshot.connectionState);
              if (snapshot.hasData) {
                return chatWidget(
                    data: obj,
                    width: widget.chatBoxWidth,
                    gameweek: gameweek,
                    leagueId: leagueId,
                    user: currentUser);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return chatWidget(
                  data: obj,
                  hydrate: false,
                  width: widget.chatBoxWidth,
                  gameweek: gameweek,
                  leagueId: leagueId,
                  user: currentUser,
                );
              } else {
                return const Text("No Data");
              }
            })
      ]);
    }
    return LandingPage();
  }
}

class chatWidget extends StatelessWidget {
  Map<String, dynamic>? data;
  bool hydrate = true;
  double width;
  double gameweek;
  double leagueId;
  Participant? user;

  chatWidget(
      {super.key,
      required this.data,
      this.hydrate = true,
      required this.width,
      required this.gameweek,
      required this.leagueId,
      required this.user});

  TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int msgLength = data?['msgLength'] ?? 1;
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
          children: List.generate(msgLength, (int index) {
        return SizedBox(
            width: width,
            child: Card(
                margin: const EdgeInsetsGeometry.fromLTRB(7, 10, 7, 0),
                elevation: 8,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Text(" " + "Temp",
                    textDirection: TextDirection.rtl,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.black26,
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                    ))));
      })),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: width - 60,
              child: TextField(
                style: const TextStyle(fontSize: 9, color: Colors.white),
                cursorColor: MaterialTheme.darkMediumContrastScheme().primary,
                controller: chatController,
                // textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    hintText: 'Send a message',
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w100,
                        fontStyle: FontStyle.italic),
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
              )),
          IconButton(
              onPressed: (
                  //TODO: Send to chat History
                  //TODO: Sync to FireStore
                  ) async {
                Message message = Message(
                    id: const Uuid().v4obj().toString(),
                    from: user,
                    timestamp: DateTime.now().toString(),
                    text: chatController.text);
                await addMessage(leagueId, gameweek, message);
                chatController.text = "";
              },
              icon: Icon(Icons.send,
                  color: MaterialTheme.darkMediumContrastScheme().primary))
        ],
      )
    ]);
  }
}
