import 'package:firebase_database/firebase_database.dart';

class KnightQuipsPlayer {
  String key;
  String playerName;
  String question1;
  String question2;
  int score;
  bool start;

  KnightQuipsPlayer(this.key, this.playerName, this.score, this.start);

  KnightQuipsPlayer.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        playerName = snapshot.value["playerName"],
        score = snapshot.value["score"],
        start = snapshot.value["start"],
        question1 = snapshot.value['q1'],
        question2 = snapshot.value['q2'];

  KnightQuipsPlayer.fromJson(DataSnapshot snapshot)
      : playerName = snapshot.value["playerName"],
        score = snapshot.value["score"],
        start = snapshot.value["start"],
        question1 = snapshot.value['q1'],
        question2 = snapshot.value['q2'];

  toJson() {
    return {
      "playerName": playerName,
      "score": score,
      "start": start,
      "q1": question1,
      "q2": question2
    };
  }
}
