library game_data;

import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Status {
  host,
  guest
}

enum NextRoom {
  voting,
  leaderboard
}

// Question/Answer
final answer = 0;
final question = 1;

Status status;
NextRoom nextRoom;
DatabaseReference gameRoom;
DatabaseReference player;
int globalNumPlayers = 0;
QuerySnapshot questionBank;