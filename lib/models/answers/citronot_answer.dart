import 'package:firebase_database/firebase_database.dart';

class CitronotAnswer {
  String key;
  String playerKey;
  String answer;
  bool correct;

  CitronotAnswer(
      this.playerKey,
      this.answer,
      { this.correct = false }
      );

  CitronotAnswer.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        playerKey = snapshot.value["playerkey"],
        answer = snapshot.value["answer"],
        correct = snapshot.value["correct"];

  CitronotAnswer.fromJson(DataSnapshot snapshot)
      : playerKey = snapshot.value["playerkey"],
        answer = snapshot.value["answer"],
        correct = snapshot.value["correct"];

  toJson() {
    return {
      "playerKey": playerKey,
      "answer": answer,
      "correct": correct
    };
  }
}