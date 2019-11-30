import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/models/players/nightNightKnightro_player.dart';
import 'package:ucfbox/game_data.dart' as game_data;

class RoleAssignment extends StatefulWidget {
  @override
  _RoleAssignmentState createState() => _RoleAssignmentState();
}

class _RoleAssignmentState extends State<RoleAssignment> {
  NightNightKnightroPlayer player;
  Map<String, NightNightKnightroPlayer> players;

  @override
  void initState() {
    super.initState();
    players = new Map();
    game_data.player.once().then((DataSnapshot snapshot) {
      player = NightNightKnightroPlayer.fromSnapshot(snapshot);
    });
//    game_data.gameRoom.child('players').onChildAdded.listen(_onPlayerAdded);
//    game_data.gameRoom.child('players').onChildChanged.listen(_onPlayersUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
              child: Image.asset('images/studentIcon.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'You are Security',
              style:
                  TextStyle(fontFamily: 'Press Start 2P', color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
