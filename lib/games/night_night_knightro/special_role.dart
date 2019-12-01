import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/games/night_night_knightro/killed_room.dart';
import 'package:ucfbox/games/night_night_knightro/knightro_role.dart';
import 'package:ucfbox/games/night_night_knightro/professor_role.dart';
import 'package:ucfbox/games/night_night_knightro/security_role.dart';
import 'package:ucfbox/games/night_night_knightro/student_role.dart';
import 'package:ucfbox/models/players/nightNightKnightro_player.dart';

import 'discussion_room.dart';

class SpecialRole extends StatefulWidget {
  @override
  _SpecialRoleState createState() => _SpecialRoleState();
}

class _SpecialRoleState extends State<SpecialRole> {
  StreamSubscription listener;
  @override
  void initState() {
    super.initState();
    game_data.gameRoom.update({'voteCount': 0});
    listener = game_data.gameRoom.onValue.listen(_onPlayersUpdate);
  }

  _onPlayersUpdate(Event event) {
    if (event.snapshot.value['voteCount'] ==
        event.snapshot.value['players'].length) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => KilledRoom()));
    }
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: FutureBuilder(
                  future: game_data.player.once(),
                  builder: (context, snap) {
                    NightNightKnightroPlayer player;
                    if (snap.data != null) {
                      player = NightNightKnightroPlayer.fromSnapshot(snap.data);
                    }
                    if (player != null) {
                      if (player.role == 'professor') {
                        return ProfessorRole();
                      } else if (player.role == 'knightro') {
                        return KnightroRole();
                      } else if (player.role == 'security') {
                        return SecurityRole();
                      } else if (player.role == 'student') {
                        return StudentRole();
                      }
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
