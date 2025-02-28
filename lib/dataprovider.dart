import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:fpl/logging.dart';
import "package:fpl/graphql_schemas.dart";
import "package:fpl/types.dart";
import "dart:js_interop";

Future<dynamic> pullStats(double? leagueId, double? gameweek) async {
  print(leagueId);
  try {
    QueryResult results = await client.value.query(QueryOptions(
        document: gql(AllQueries.getLeagueStats), //
        fetchPolicy: null,
        cacheRereadPolicy: null,
        variables: {
          "leagueId": leagueId, //538731,
          "gameweek": gameweek, //3
        }));
    // Log.logger.i("Pulling Events Exception: ${results.exception}");
    // print(results.exception);
    // print(results.data?['captain']);
    // for (var data in results.data?['captain']) {
    // print(data);
    // Log.logger.i(data);

    // print(results.data);

    return results;
    // }
  } catch (e) {
    print(e);
    return false;
    // Log.logger.e("Error during synchronization: $e");
  }
}

Future<dynamic> pullPlayerStats(double? playerId, double? gameweek) async {
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
  try {
    QueryResult results = await client.value.query(QueryOptions(
        document: gql(AllQueries.getParticipantStats), //
        fetchPolicy: null,
        cacheRereadPolicy: null,
        variables: {
          "entryId": participantId, //4,
        }));
    return results;
    // }
  } catch (e) {
    print(e);
    return false;
    // Log.logger.e("Error during synchronization: $e");
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
  return 9; //Should start from current gameweek
});

final participantIdProvider = StateProvider<double?>((ref) {
  return null; //Should start from current gameweek
});

final currentUserProvider = StateProvider<User?>((ref) {
  return null;
});
