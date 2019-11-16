import 'package:firebase_database/firebase_database.dart';

class KnightQuipsPlayer {
  String key;
  String playerName;
  int score;
  bool start;

  KnightQuipsPlayer(
    this.playerName, this.score, this.start);

  KnightQuipsPlayer.fromSnapshot(DataSnapshot snapshot)
    : key = snapshot.key,
      playerName = snapshot.value["playerName"],
      score = snapshot.value["score"],
      start = snapshot.value["start"];
  
    KnightQuipsPlayer.fromJson(DataSnapshot snapshot)
    : playerName = snapshot.value["playerName"],
      score = snapshot.value["score"],
      start = snapshot.value["start"];

  toJson() {
    return {
      "playerName": playerName,
      "score": score,
      "start": start
    };
  }
}