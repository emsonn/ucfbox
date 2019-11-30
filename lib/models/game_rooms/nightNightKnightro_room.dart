import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import '../players/nightNightKnightro_player.dart';

class NightNightKnightroRoom {
  String key;
  String gameType;
  Map players;
  List randomRoles;
  int alivePlayersCount;
  int voteCount;
  String killed;
  bool isDaytime;

  NightNightKnightroRoom(this.gameType, this.players, this.alivePlayersCount,
      this.isDaytime, this.killed, this.voteCount);

  NightNightKnightroRoom.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        players = playersMap(snapshot),
        randomRoles = snapshot.value["randomRoles"],
        alivePlayersCount = snapshot.value["alivePlayersCount"],
        voteCount = snapshot.value["voteCount"],
        killed = snapshot.value["killed"],
        isDaytime = snapshot.value["isDaytime"];

  static Map playersMap(DataSnapshot snapshot) {
    Map<String, NightNightKnightroPlayer> players = Map();
    snapshot.value["players"].forEach((k, v) => {
          players.putIfAbsent(k, () {
            return NightNightKnightroPlayer.fromJson(v);
          })
        });

    return players;
  }

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
