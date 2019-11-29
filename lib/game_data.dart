library game_data;

import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Status {
  host,
  guest
}

enum NextRoom {
  voting,
  leaderboard,
  question
}

// Question/Answer
final answer = 0;
final question = 1;

// CitroNot GameData -- Maybe moved to more General as other games progress.
Status status;
NextRoom nextRoom;
List<int> deck;
QuerySnapshot questionBank;
int globalNumPlayers = 0;
int citronotNumRounds = 2; // 0 inclusive
int numCitronotQuestions = 23; // 0-22

// Database References
DatabaseReference gameRoom;
DatabaseReference player;
