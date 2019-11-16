import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/models/players/knightquips_player.dart';
class KnightQuipsRoom {
  String key;
  int noOfPlayers;
  String gameType;
  List<KnightQuipsPlayer> players;
  int voteCount;
  List allTopics;
  String topic;
  List answers;

  KnightQuipsRoom(
      {this.key,
      this.noOfPlayers,
      this.gameType,
      this.players,
      this.voteCount,
      this.allTopics,
      this.topic,
      this.answers});

  KnightQuipsRoom.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.value['key'],
        noOfPlayers = snapshot.value['noOfPlayers'],
        gameType = snapshot.value['gameType'],
        players = snapshot.value['players'],
        voteCount = snapshot.value['voteCount'],
        allTopics = snapshot.value['allTopics'],
        topic = snapshot.value['topic'],
        answers = snapshot.value['answers'];
}
