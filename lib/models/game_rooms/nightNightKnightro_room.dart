import 'package:firebase_database/firebase_database.dart';

class NightNightKnightroRoom {
  String key;
  String gameType;
  Map players;
  int alivePlayersCount;
  int voteCount;
  String killed;
  bool isDaytime;

  NightNightKnightroRoom(this.gameType, this.players, this.alivePlayersCount,
      this.isDaytime, this.killed, this.voteCount);

  NightNightKnightroRoom.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        players = snapshot.value["players"],
        alivePlayersCount = snapshot.value["alivePlayersCount"],
        voteCount = snapshot.value["voteCount"],
        killed = snapshot.value["killed"],
        isDaytime = snapshot.value["isDaytime"];

  toJson() {
    return {
      "gameType": gameType,
      "players": players,
      'alivePlayersCount': alivePlayersCount,
      'voteCount': voteCount,
      'killed': killed,
      'isDaytime': isDaytime
    };
  }
}
