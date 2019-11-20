/// THE TYPES OF LIST HAVE TO CHANGE FOR
/// ALLTOPICS AND ANSWER
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/games/knightquips/knightquips.dart';
import 'package:ucfbox/models/players/knightquips_player.dart';

class KnightQuipsRoom {
  String key;
  int noOfPlayers;
  String gameType;
  List<KnightQuipsPlayer> players;
/// Moving the answer and vote to the player object would eliminate
/// the nesting in "allTopics".
/// The answer and votes will always be re-writen.
///
/// Since they are so close to the player object itself I find it 
/// that it makes sense for this game in particular.
/// 
/// By doing so we eliminate most of allTopics nesting. The thing that 
/// we would have inside is just a list of the topics that we already
/// played. 
/// 
/// "players": [
///       {
///           "playersName": Emanuel,
///           "score": 1,
///           "votes": 3,
///           "answer": Do work,
///           "start": true,
///       }
/// ],
/// "voteCount": 5,
/// "allTopics": [
///       {
///           "topic": topic1,
///           "topic": topic2,
///       }
/// ]
  int voteCount;
  
  List<KnightQuipsPlayer> allTopics;
  String topic;
  List<KnightQuipsPlayer> answers;

  KnightQuipsRoom(
      {this.key,
      this.noOfPlayers,
      this.gameType,
      this.players,
      this.voteCount,
      this.answers});

  KnightQuipsRoom.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        noOfPlayers = snapshot.value['noOfPlayers'],
        gameType = snapshot.value['gameType'],
        players = (snapshot.value['players'] as List).map((i) {
          return KnightQuipsPlayer.fromJson(i);
        }).toList(),
        voteCount = snapshot.value['voteCount'],

        /// Need to change the TYPE of list
        allTopics = (snapshot.value['allTopics'] as List).map((i) {
          return KnightQuipsPlayer.fromJson(i);
        }).toList(),
        answers = (snapshot.value['allTopics'] as List).map((i) {
          return KnightQuipsPlayer.fromJson(i);
        }).toList();
}
