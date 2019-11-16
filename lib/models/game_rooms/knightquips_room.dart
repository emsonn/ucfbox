import 'package:firebase_database/firebase_database.dart';

class KnightQuipsRoom {
  int noOfPlayers;
  String gameType;
  List players;
  int voteCount;
  List allTopics;
  String topic;
  List answers;

  KnightQuipsRoom(
      {this.noOfPlayers,
      this.gameType,
      this.players,
      this.voteCount,
      this.allTopics,
      this.topic,
      this.answers});

  KnightQuipsRoom.fromSnapshot(DataSnapshot snapshot)
      : noOfPlayers = snapshot.value['noOfPlayers'],
        gameType = snapshot.value['gameType'],
        players = snapshot.value['players'],
        voteCount = snapshot.value['voteCount'],
        allTopics = snapshot.value['allTopics'],
        topic = snapshot.value['topic'],
        answers = snapshot.value['answers'];


        toJson(){
          return {
            'noOfPlayers': noOfPlayers,
            'gameType': gameType,
            'players': players,
            'voteCount': voteCount,
            'allTopics': allTopics,
            'topic': topic,
            'answers': answers
          };
        }
}
