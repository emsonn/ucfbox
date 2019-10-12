import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../my_app_bar.dart';
import 'generateCode.dart';

class NightNightKnightro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    createNightNightKnightroRoom();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(),
      body: SafeArea(
        child: Center(
          child: Text(
            "NIGHTNIGHTKNIGHTRO GAME PLAY",
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

void createNightNightKnightroRoom() {
  FirebaseDatabase.instance.reference().child(generateCode()).set({
    "gameType": "nightNightKnightro",
    "players": [],
    "alivePlayersCount": 0,
    "voteCount": 0,
    "killed": "",
    "isDaytime": false,
  });
}
