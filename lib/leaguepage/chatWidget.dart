import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';
import 'package:fpl/themes.dart';
import 'package:fpl/types.dart';

import '../individualpage/participantview.dart';

class Chat extends ConsumerStatefulWidget {
  final double chatBoxWidth;
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
    final Stream<DocumentSnapshot>? messageStream =
        LeagueDbRef.doc(leagueId.toString())
            .collection("messages")
            .doc(gameweek.toString())
            .snapshots();

    if (leagueId != null) {
      return Column(children: [
        StreamBuilder(
            stream: messageStream,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              var obj = snapshot.data?.data();
              if (snapshot.hasData) {
                return chatWidget(
                    data: obj as Map<String, dynamic>?,
                    width: widget.chatBoxWidth,
                    gameweek: gameweek,
                    leagueId: leagueId,
                    user: currentUser);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return chatWidget(
                  data: obj as Map<String, dynamic>?,
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
  final double width;
  final double gameweek;
  final double leagueId;
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
  ScrollController chatScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    int msgLength = data?.length ?? 0;
    List<Map<String, dynamic>> sortedMessages =
        List<Map<String, dynamic>>.from(data?.values ?? []);
    sortedMessages.sort((a, b) => a["timestamp"].compareTo(b['timestamp']));
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      const Gap(5),
      Text("Banter Zone",
          style: TextStyle(
              color: MaterialTheme.darkMediumContrastScheme()
                  .primary)), //TODO: Design Text
      const Gap(5),
      SizedBox(
          // height: 300,
          child: Scrollbar(
              trackVisibility: true,
              thickness: 4,
              child: SingleChildScrollView(
                  controller: chatScroll,
                  child: Column(
                      children: List.generate(msgLength, (int index) {
                    Duration messageTimeStamp = DateTime.now().difference(
                        DateTime.parse(sortedMessages
                            .elementAt(index)["timestamp"]
                            .toString()));
                    return SizedBox(
                        // width: width,
                        child: Card(
                            margin:
                                const EdgeInsetsGeometry.fromLTRB(7, 10, 7, 0),
                            elevation: 8,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Padding(
                                padding: const EdgeInsetsGeometry.fromLTRB(
                                    4, 0, 4, 0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          sortedMessages.length > index
                                              ? " " +
                                                  sortedMessages
                                                      .elementAt(index)["from"]
                                              : " ",
                                          softWrap: true,
                                          style: TextStyle(
                                              color: MaterialTheme
                                                      .darkMediumContrastScheme()
                                                  .primary,
                                              fontSize: 9,
                                              fontStyle: FontStyle.italic)),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                sortedMessages.length > index
                                                    ? messageTimeStamp.inDays >
                                                            0
                                                        ? "${messageTimeStamp.inDays} days ago"
                                                        : messageTimeStamp
                                                                    .inHours >
                                                                0
                                                            ? "${messageTimeStamp.inHours} hours ago"
                                                            : messageTimeStamp
                                                                        .inMinutes >
                                                                    0
                                                                ? "${messageTimeStamp.inMinutes} minutes ago"
                                                                : "${messageTimeStamp.inSeconds} seconds ago"
                                                    : " ",
                                                // textDirection: TextDirection.rtl,
                                                softWrap: true,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                )),
                                            SizedBox(width: 10),
                                            Flexible(
                                                child: Text(
                                                data != null
                                                    ? " " +
                                                        sortedMessages
                                                            .elementAt(
                                                                index)["text"]
                                                    : " ",
                                                // textDirection: TextDirection.rtl,
                                                softWrap: true,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11,
                                                  overflow: TextOverflow.clip,
                                                )),
                                            )])
                                    ]))));
                  }))))),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: width - 60,
              child: TextField(
                style: const TextStyle(fontSize: 9, color: Colors.white),
                cursorColor: MaterialTheme.darkMediumContrastScheme().primary,
                controller: chatController,
                textInputAction: TextInputAction.newline,
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
              onPressed: () async {
                Message message = Message(
                    id: const Uuid().v4obj().toString(),
                    from: user,
                    timestamp: DateTime.now().toString(),
                    text: chatController.text);
                await addMessage(leagueId, gameweek, message);
                chatController.clear();
              },
              icon: Icon(Icons.send,
                  color: MaterialTheme.darkMediumContrastScheme().primary))
        ],
      )
    ]);
  }
}
