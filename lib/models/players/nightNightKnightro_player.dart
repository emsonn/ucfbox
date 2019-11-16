import 'package:firebase_database/firebase_database.dart';

class NightNightKnightroPlayer {
  String key;
  bool alive;
  String playerName;
  String role;
  bool start;
  int votes;

  NightNightKnightroPlayer(
      this.alive, this.playerName, this.role, this.start, this.votes);

  NightNightKnightroPlayer.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        alive = snapshot.value["alive"],
        playerName = snapshot.value["playerName"],
        role = snapshot.value["role"],
        start = snapshot.value["start"],
        votes = snapshot.value["votes"];

  NightNightKnightroPlayer.fromJson(Map jsonMap)
      : alive = jsonMap["alive"],
        playerName = jsonMap["playerName"],
        role = jsonMap["role"],
        start = jsonMap["start"],
        votes = jsonMap["votes"];

  toJson() {
    return {
      "alive": alive,
      "playerName": playerName,
      "role": role,
      "start": start,
      "votes": votes
    };
  }
}
