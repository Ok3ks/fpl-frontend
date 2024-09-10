import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:fpl/logging.dart';
import "package:fpl/graphql_schemas.dart";
import "dart:js_interop";

Future<dynamic> pullStats(double leagueId, double gameweek) async {
  try {
    QueryResult results = await client.value.query(QueryOptions(
        document: gql(AllQueries.getLeagueStats), //
        fetchPolicy: null,
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

    return results;
    // }
  } catch (e) {
    return false;
    // Log.logger.e("Error during synchronization: $e");
  }
}

// final leagueStatsProvider = FutureProvider<dynamic>((ref) async {
//   dynamic result = await pullStats();
//   return result;
// });
