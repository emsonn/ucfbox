import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/games/night_night_knightro/how_to_play.dart';
import 'package:ucfbox/games/night_night_knightro/discussion_room.dart';
import 'package:ucfbox/games/night_night_knightro/start_status_box.dart';
import 'package:ucfbox/models/game_rooms/nightNightKnightro_room.dart';
import 'package:ucfbox/models/players/nightNightKnightro_player.dart';
import 'package:ucfbox/game_data.dart' as game_data;

class NightNightKnightro extends StatefulWidget {
  @override
  _NightNightKnightroState createState() => _NightNightKnightroState();
}

class _NightNightKnightroState extends State<NightNightKnightro> {
  NightNightKnightroPlayer player;
  NightNightKnightroRoom room;
  int roleSeed;
  StreamSubscription listener;

  @override
  void initState() {
    super.initState();
    print(game_data.player.key);
    game_data.player.once().then((DataSnapshot snapshot) {
      player = NightNightKnightroPlayer.fromSnapshot(snapshot);
    });

    game_data.gameRoom.once().then((DataSnapshot snapshot) {
      room = NightNightKnightroRoom.fromSnapshot(snapshot);
      print('no of players ${snapshot.value["noOfPlayers"]}');
      roleSeed = snapshot.value["noOfPlayers"];
      print(roleSeed);
    });
    listener = game_data.gameRoom.onValue.listen(_onPlayersUpdate);
  }

  _onPlayersUpdate(Event event) {
    print('updated');
    var starts = 0;
    event.snapshot.value['players']
        .forEach((k, v) => {v['start'] ? starts++ : null});
    print(event.snapshot.value['players'].length);
    if (starts == event.snapshot.value['players'].length &&
        event.snapshot.value['players'].length >= 4) {
      print('enter');
      game_data.player
          .update({'role': event.snapshot.value['randomRoles'][roleSeed]});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DiscussionRoom()),
      );
    }
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  handleStart() {
    game_data.player.update({'start': !player.start});
    setState(() {
      player.start = !player.start;
    });
  }

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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                'game code: ${game_data.gameRoom.key}',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Press Start 2P'),
              ),
            ),
            StartStatusBox(),
            FlatButton(
              child: Text(
                'Start',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Press Start 2P'),
              ),
              onPressed: () {
                handleStart();
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
