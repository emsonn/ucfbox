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
