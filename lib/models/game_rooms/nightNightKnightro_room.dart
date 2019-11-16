import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import '../players/nightNightKnightro_player.dart';

class NightNightKnightroRoom {
  String key;
  String gameType;
  List<NightNightKnightroPlayer> players;
  int alivePlayersCount;
  int voteCount;
  String killed;
  bool isDaytime;

  NightNightKnightroRoom(this.gameType, this.players, this.alivePlayersCount,
      this.isDaytime, this.killed, this.voteCount);

  NightNightKnightroRoom.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        players = (snapshot.value['players'] as List).map((i) {
          print(snapshot.value['players']);
          return NightNightKnightroPlayer.fromJson(i);
        }).toList(),
        gameType = snapshot.value["gameType"],
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
