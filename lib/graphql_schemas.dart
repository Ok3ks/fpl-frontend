import 'package:graphql_flutter/graphql_flutter.dart';
//import 'package:flutter/foundation.dart';
import "constants.dart";
import "package:flutter/material.dart";

final HttpLink _httpLink = HttpLink(
  Constants.prodUrl,
  // defaultHeaders: {
  //   'AuthorizationSource': 'API',
  // },
);

final ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
  link: _httpLink,
  cache: GraphQLCache(), //specify cache
));

class AllQueries {
  static String getLeagueStats = """
 
  query leagueScore(\$leagueId: Int!, \$gameweek: Int!) {
    
    leagueWeeklyReport(leagueId: \$leagueId, gameweek:\$gameweek) {
      captain{
        player
        count
      }
      exceptional{
        teamName
        score
      }
      abysmal{
        teamName
        score
      }
      promotedVice{
        promotedVicePoints
        participantsName
        captainName
        viceCaptainName
      }
      leagueAverage
      rise{
        currentRank
        prevRank
        participantName
      }
      fall {
        currentRank
        prevRank
        participantName
      }
      mostTransferredOut{
        player
        out
      }
      mostTransferredIn{
        player
        in
      }
      bestTransferIn{
        entryId
        teamName
        playerIn
        playerOut
        pointsDelta
        pointHit
      }
      worstTransferIn{
        entryId
        teamName
        playerIn
        playerOut
        pointsDelta
        pointHit
      }
      mostPointsOnBench{
        teamName
        players
        pointOnBench
      }
      jammyPoints{
        teamName
        subIn
        subOut
        points
      }
      mostBenched {
        player
        count
        points
      }
      leagueName
    }
  }""";

  static String getPlayerStats = """
  
  query players(\$id: Int!, \$gameweek:Int!) {
  
    player (id: \$id, gameweek:\$gameweek) {
      
      playerId
      info {
        team
        half
        position
        playerName
        playerId
      }
      gameweekScore {
        playerId
        minutes
        goalsScored
        assists
        cleanSheets
        goalsConceded
        ownGoals
        penaltiesSaved
        penaltiesMissed
        yellowCards
        redCards
        saves
        bonus
        bps
        influence
        creativity
        threat
        ictIndex
        starts
        expectedGoals
        expectedAssists
        expectedGoalInvolvements
        expectedGoalsConceded
        totalPoints
        inDreamteam
        gameweek
      }
    }
  }""";

  static String getParticipantStats = """
  query participantReport(\$entryId: Int!) {
    participantReport(entryId: \$entryId) {
      gw
      entryId
      totalPoints
      players
      bench
      captain {
        playerId
        info {
          playerName
          position
        }
        gameweekScore {
          playerId
          goalsScored
          assists
          cleanSheets
          bonus
        }
      }
      viceCaptain {
        playerId
        info {
          playerName
          position
        }
        gameweekScore {
          playerId
          goalsScored
          assists
          cleanSheets
          bonus
        }
      }
      highestScoringPlayer {
        playerId
        info {
          playerName
          position
        }
        gameweekScore {
          playerId
          goalsScored
          assists
          cleanSheets
          bonus
        }
      }
      captainPoints
      viceCaptainPoints
      highestScoringPlayerPoints
      activeChip
      eventTransfersCost
      pointsOnBench
  }
}
  """;

  static String getGameViewReport = """
  query GameViewReport(\$useGameweek: Boolean!, \$usePosition: Boolean!, \$useTeam: Boolean!) {
    gameViewReport(useGameweek: \$useGameweek, usePosition: \$usePosition, useTeam: \$useTeam) {
        gameweek
        position
        team
        goalsScored
        totalPoints
        assists
    }
  }
  """;

  static String getPlayersStats = """
  
  query players(\$ids: [Int!]!, \$gameweek:Int!) {
    players (ids: \$ids, gameweek:\$gameweek) {
      playerId
      info {
        team
        half
        position
        playerName
        playerId
      }
      gameweekScore {
        playerId
        minutes
        goalsScored
        assists
        cleanSheets
        goalsConceded
        ownGoals
        penaltiesSaved
        penaltiesMissed
        yellowCards
        redCards
        saves
        bonus
        bps
        influence
        creativity
        threat
        ictIndex
        starts
        expectedGoals
        expectedAssists
        expectedGoalInvolvements
        expectedGoalsConceded
        totalPoints
        inDreamteam
        gameweek
      }
    }
  }""";
}
