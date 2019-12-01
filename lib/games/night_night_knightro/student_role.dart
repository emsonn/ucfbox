import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/game_data.dart' as game_data;

class StudentRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    game_data.gameRoom.child('voteCount').once().then((DataSnapshot snapshot) {
      print(snapshot.value);
      game_data.gameRoom.update({'voteCount': snapshot.value + 1});
    });
    return Container(
      child: Center(
        child: Text(
          'You are a student,\nwait for the others',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontFamily: 'Press Start 2P'),
        ),
      ),
    );
  }
}
