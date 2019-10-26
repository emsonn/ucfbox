import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../my_app_bar.dart';
import 'generate_code.dart';

class Citronot extends StatelessWidget {
  Citronot({this.playerName});
  final playerName;

  @override
  Widget build(BuildContext context) {
    createCitronotRoom(playerName);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(),
      body: SafeArea(
        child: Center(
          child: Text(
            "CITRONOT GAME PLAY",
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

void createCitronotRoom(String playerName) {
  FirebaseDatabase.instance.reference().child(generateCode()).set({
    "gameType": "citronot",
    "players": [
      {
        "playerName": playerName,
        "score": 0,
        "start": false,
        "answer": "",
      }
    ],
    "voteCount": 0,
    "allTopics": [],
  });
}
