import 'package:firebase_database/firebase_database.dart';

class CitronotPlayer {
  String key;
  String playerName;
  int score;
  bool start;
  String answer;

  CitronotPlayer(
      this.playerName, this.score, this.start, this.answer);

  CitronotPlayer.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        playerName = snapshot.value["playerName"],
        score = snapshot.value["score"],
        start = snapshot.value["start"],
        answer = snapshot.value["answer"];

  toJson() {
    return {
      "playerName": playerName,
      "score": score,
      "start": start,
      "answer": answer
    };
  }
}