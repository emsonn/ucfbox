import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../my_app_bar.dart';
import 'generateCode.dart';

class Citronot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    createCitronotRoom();
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

void createCitronotRoom() {
  FirebaseDatabase.instance.reference().child(generateCode()).set({
    "gameType": "citronot",
    "players": [],
    "voteCount": 0,
    "allTopics": [],
  });
}
