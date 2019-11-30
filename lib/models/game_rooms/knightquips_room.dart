/// THE TYPES OF LIST HAVE TO CHANGE FOR
/// ALLTOPICS AND ANSWER
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/games/knightquips/knightquips.dart';
import 'package:ucfbox/models/players/knightquips_player.dart';

class KQuipsRoom {
  String key;
  String gameType;
  int noOfPlayers;
  int nextRoom;
  int answerCount;
  Map players;
  Map questions;

  KQuipsRoom.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        gameType = snapshot.value['gameType'],
        noOfPlayers = snapshot.value['noOfPlayers'],
        answerCount = snapshot.value['answerCount'],
        players = snapshot.value['players'],
        questions = snapshot.value['questions'];

  toJson() {
    return {
      "gameType": gameType,
      "noOfPlayers": noOfPlayers,
      "answerCount": answerCount,
      "players": players,
      "questions": questions
    };
  }
}