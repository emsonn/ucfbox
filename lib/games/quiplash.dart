import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../my_app_bar.dart';
import 'generateCode.dart';

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
          child: Text(
            "QUIPLASH GAME PLAY",
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
