import 'package:firebase_database/firebase_database.dart';
import '../players/citronot_player.dart';

class CitronotRoom {
  String key;
  int noOfPlayers;
  String gameType;
  List<CitronotPlayer> players;
  String prompt;
  String fact;
  int answerCount;

  CitronotRoom(
      this.gameType, this.players, this.prompt, this.fact, this.answerCount);

  CitronotRoom.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        noOfPlayers = snapshot.value['noOfPlayers'],
        players = (snapshot.value['players'] as List).map((i) {
          return CitronotPlayer.fromJson(i);
        }).toList(),
        gameType = snapshot.value["gameType"],
        prompt = snapshot.value["prompt"],
        fact = snapshot.value["fact"],
        answerCount = snapshot.value["answerCount"];

  toJson() {
    return {
      "gameType": gameType,
      "players": players.map((i) {
        return i.toJson();
      }).toList(),
      'prompt': prompt,
      'fact': fact,
      'answerCount': answerCount
    };
  }
}
