import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../my_app_bar.dart';
import 'generateCode.dart';

class Quiplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

void createQuiplash() {
  FirebaseDatabase.instance.reference().child(generateCode()).set({
    "gameType": "quiplash",
    "players": [],
    "currentFact": "",
    "answerCount": 0,
  });
}
