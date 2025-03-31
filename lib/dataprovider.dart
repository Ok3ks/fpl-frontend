import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:fpl/logging.dart';
import "package:fpl/graphql_schemas.dart";
import "package:fpl/types.dart";
import "package:cloud_firestore/cloud_firestore.dart";

CollectionReference userDbRef = FirebaseFirestore.instance.collection("users");

Future<void> addLeagueGlobal(
    double leagueId, double gameweek, Map<String, dynamic>? result) async {
  """Adds to Global League FireStore for other users""";

  //Save to global league firestore collection
  CollectionReference LeagueDbRef =
      FirebaseFirestore.instance.collection("leagues/");

  DocumentReference temp = LeagueDbRef.doc(leagueId.toString());
  temp.set({gameweek.toString(): result}, SetOptions(merge: true));

  print("added to global league successfully");
}

Future<Object?> getLeagueGlobal(double? leagueId) async {
  //Try individually, before downloading whole blob onto machine.

  CollectionReference LeagueDbRef =
      FirebaseFirestore.instance.collection("leagues/");
  final snapshot = await LeagueDbRef.doc(leagueId.toString()).get();
  final temp = snapshot.data();
  return temp;
}

Future<dynamic> pullStats(double? leagueId, double? gameweek) async {
  //First check firebase store, otherwise check backend

  // Map<String, dynamic> leagueRefResults =
  //     await getLeagueGlobal(leagueId) as Map<String, dynamic>;
  // dynamic response = leagueRefResults[gameweek.toString()];
  // print('response');
  // print(response);
  //
  // if (response != null) {
  //   return Future.value(leagueRefResults[gameweek.toString()]);
  // } else {
  try {
    QueryResult results = await client.value.query(QueryOptions(
        document: gql(AllQueries.getLeagueStats), //
        fetchPolicy: null,
        cacheRereadPolicy: null,
        variables: {
          "leagueId": leagueId, //538731,
          "gameweek": gameweek, //3
        }));
    if (gameweek != null && leagueId != null) {
      //add to global firestore cache
      await addLeagueGlobal(leagueId, gameweek, results.data);
    }
    return results.data;
  } catch (e) {
    print(e);
    // Log.logger.e("Error during synchronization: $e");
    return false;
  }
  // }
}

Future<dynamic> pullPlayerStats(int? playerId, double? gameweek) async {
  try {
    QueryResult results = await client.value.query(QueryOptions(
        document: gql(AllQueries.getPlayerStats), //
        fetchPolicy: null,
        cacheRereadPolicy: null,
        variables: {
          "id": playerId, //4,
          "gameweek": gameweek, //3
        }));
    return results;
    // }
  } catch (e) {
    print(e);
    return false;
    // Log.logger.e("Error during synchronization: $e");
  }
}

Future<dynamic> pullParticipantStats(double? participantId) async {
  // final box
  final local = GetStorage();
  final results = local.read("participantStats");

  if (results != null) {
    return results;
  } else {
    try {
      QueryResult results = await client.value.query(QueryOptions(
          document: gql(AllQueries.getParticipantStats), //
          fetchPolicy: null,
          cacheRereadPolicy: null,
          variables: {
            "entryId": participantId, //4,
          }));
      local.write("participantStats", results.data);
      return results.data;
    } catch (e) {
      print(e);
      return false;
      // Log.logger.e("Error during synchronization: $e");
    }
  }
}

Future<dynamic> pullGameViewStats(
  bool useGameweek,
  bool usePosition,
  bool useTeam,
) async {
  try {
    QueryResult results = await client.value.query(QueryOptions(
        document: gql(AllQueries.getGameViewReport), //
        fetchPolicy: null,
        cacheRereadPolicy: null,
        variables: {
          "useGameweek": useGameweek,
          "usePosition": usePosition,
          "useTeam": useTeam,
        }));
    print("${results.data}");
    return results;
  } catch (e) {
    Log.logger.e("Error during synchronization: $e");
    return false;
  }
}

Future<dynamic> pullPlayersStats(
    List<double?> playerIds, double? gameweek) async {
  try {
    QueryResult results = await client.value.query(QueryOptions(
        document: gql(AllQueries.getPlayersStats), //
        fetchPolicy: null,
        cacheRereadPolicy: null,
        variables: {
          "ids": playerIds, //4,
          "gameweek": gameweek, //3
        }));
    return results;
    // }
  } catch (e) {
    print(e);
    return false;
    // Log.logger.e("Error during synchronization: $e");
  }
}

final leagueProvider = StateProvider<double?>((ref) {
  return null;
});

final gameweekProvider = StateProvider<double>((ref) {
  return 28; //Should start from current gameweek
});

var currentUserProvider = StateProvider<Participant?>((ref) {
  final local = GetStorage();
  final userData = local.read('participant');
  if (userData != null) {
    Participant currentParticipant = Participant(
      email: userData['email'],
      favoriteTeam: userData['favoriteTeam'],
      participantId: userData['participantId'],
      yearsPlayingFpl: userData['yearsPlayingFpl'],
      username: userData['username'],
    );
    return currentParticipant;
  }
  return null;
});
