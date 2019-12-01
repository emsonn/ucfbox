library game_data;

import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Status { host, guest }

enum NextRoom { voting, leaderboard, question }

enum KQuipsRooms { question1, question2, voting, leaderboard }

// Question/Answer
final answer = 0;
final question = 1;
final topics = 0;

// CitroNot GameData -- Maybe moved to more General as other games progress.
Status status;
NextRoom nextRoom;
List<int> deck;
List<int> questionList;
QuerySnapshot questionBank;
int globalNumPlayers = 0;
int citronotNumRounds = 2; // 0 inclusive
int citronotNumQuestions = 24; // 0-23
int citronotMinNumPlayers = 4;
int citronotMaxNumPlayers = 8;

// KnightQuips GameData
int knightQuipsNumQuestions = 49; // 0-48
int knightQuipsMinNumPlayers = 4;
int knightQuipsMaxNumPlayers = 8;

// Knight Quips GameData
int numKQuipsQuestions = 48; // 0-48
String question1;
String question2;
KQuipsRooms kQuipsRooms;
List<String> needToVoteFor;

// Database References
DatabaseReference gameRoom;
DatabaseReference player;
