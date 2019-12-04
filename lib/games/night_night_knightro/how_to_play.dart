import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';

class HowToPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      '''Night Night Knightro is a UCF spinoff of current games "Secret Hitler" or "Mafia".\n\n
First, each player will be assigned one out of four roles:\n\n
Knightro: You are the killer in the game. Your main goal is to eliminate all of the players until it’s just you and another person "alive" without getting caught. \n\n
Doctor: Each round, if you're alive you are allowed to potentially "save" someone from being killed off. It can be yourself or another person. The only thing is that you cannot choose the same person twice in a row.\n\n
Security: Your main goal each round is to guess who is Knightro where you will receive a yes or no response from the Narration system in the game. If you end up guessing correctly, you may reveal that in the discussion, but you must persuade everyone that Knightro is who they are, or you may end up dead next if Knightro sees you as a threat.\n\n
Student: You basically try to figure out Knightro based off the discussion only. You have to plead your case that you are a student and hope you and your fellow students stay alive until Knightro is found or else you lose the game.\n\n
Each round of discussion carries on for 60 seconds which at the end everyone votes to find out who Knightro is.  This process repeats until the students and officer and doctor win by revealing Knightro, but if choose the wrong person as Knightro, that person they voted on is now dead as well.\n\n
Good luck!''',
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Press Start 2P',
                          color: Colors.white,
                          fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                FlatButton(
                  child: Text('Return',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Press Start 2P')),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
