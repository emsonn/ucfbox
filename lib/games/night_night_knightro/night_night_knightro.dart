import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/games/night_night_knightro/how_to_play.dart';
import 'package:ucfbox/games/night_night_knightro/role_assignment.dart';
import 'package:ucfbox/models/players/nightNightKnightro_player.dart';
import 'package:ucfbox/game_data.dart' as game_data;

class NightNightKnightro extends StatefulWidget {
  @override
  _NightNightKnightroState createState() => _NightNightKnightroState();
}

class _NightNightKnightroState extends State<NightNightKnightro> {
  List<NightNightKnightroPlayer> players;
  @override
  void initState() {
    super.initState();
    game_data.gameRoom.child('players').onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Image.asset(
              'images/nightNightKnightroSplash.png',
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              child: Text(
                'Start',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Press Start 2P'),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RoleAssignment()));
              },
            ),
            FlatButton(
              child: Text(
                'How to Play',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Press Start 2P'),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HowToPlay()));
              },
            )
          ],
        ),
      ),
    );
  }
}
