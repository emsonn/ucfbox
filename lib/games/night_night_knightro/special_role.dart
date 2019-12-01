import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/games/night_night_knightro/professor_role.dart';
import 'package:ucfbox/models/players/nightNightKnightro_player.dart';

import 'discussion_room.dart';

class SpecialRole extends StatefulWidget {
  @override
  _SpecialRoleState createState() => _SpecialRoleState();
}

class _SpecialRoleState extends State<SpecialRole> {
  @override
  void initState() {
    super.initState();
    game_data.gameRoom.onValue.listen(_onPlayersUpdate);
  }

  _onPlayersUpdate(Event event) {
    print('1 ${event.snapshot.value['players']}');
    var starts = 0;
    event.snapshot.value['players']
        .forEach((k, v) => {v['start'] ? starts++ : null});
    if (starts == event.snapshot.value['players'].length &&
        event.snapshot.value['players'].length >= 4) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DiscussionRoom()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
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
                      } else if (player.role == 'security') {}
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
