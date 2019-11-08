import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../my_app_bar.dart';
import 'generate_code.dart';

class Quiplash extends StatelessWidget {
  Quiplash({this.playerName});
  final playerName;

  @override
  Widget build(BuildContext context) {
    createQuiplash(playerName);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(),
      body: SafeArea(
        child: Center(
          // Trying to display the players name
          child: Text(
            "QUIPLASH GAME PLAY\n$playerName",
            style: TextStyle(
              fontSize: 60,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

//// Why is this outside of the class?
/// Is it a global variable?
void createQuiplash(String playerName) {
  FirebaseDatabase.instance.reference().child(generateCode()).set({
    "gameType": "quiplash",
    "players": [
      {
        "playerName": playerName,
        "score": 0,
        "start": false,
        "answer": "",
      }
    ],
    "currentFact": "",
    "answerCount": 0,
  });
}
