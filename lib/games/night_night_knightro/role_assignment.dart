import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/games/night_night_knightro/discussion_timer.dart';
import 'package:ucfbox/models/game_rooms/nightNightKnightro_room.dart';
import 'package:ucfbox/models/players/nightNightKnightro_player.dart';
import 'package:ucfbox/game_data.dart' as game_data;

class RoleAssignment extends StatefulWidget {
  @override
  _RoleAssignmentState createState() => _RoleAssignmentState();
}

class _RoleAssignmentState extends State<RoleAssignment> {
  NightNightKnightroPlayer player;
  NightNightKnightroRoom room;
  String image;
  bool showRole = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: game_data.gameRoom.once(),
        builder: (context, snap) {
          if (snap.data != null) {
            room = NightNightKnightroRoom.fromSnapshot(snap.data);
            player = NightNightKnightroPlayer.fromJson(
                snap.data.value['players'][game_data.player.key]);
          }
          if (player != null) {
            return GestureDetector(
              onTapUp: (_) {
                setState(() {
                  showRole = false;
                });
              },
              onTapDown: (_) {
                setState(() {
                  showRole = true;
                });
              },
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      showRole
                          ? Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 50, 30, 20),
                                  child: Image.asset(image),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'You are ${player.role == 'knightro' || player.role == 'security' ? player.role : 'a ' + player.role}',
                                  style: TextStyle(
                                      fontFamily: 'Press Start 2P',
                                      color: Colors.white),
                                ),
                              ],
                            )
                          : Container(),
                      showRole
                          ? Container()
                          : Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 50, 30, 20),
                              child: Container(
                                width: 351,
                                height: 385,
                                child: Center(
                                  child: Image.asset(
                                    'images/lightbulb.png',
                                    scale: 5,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container();
        });
  }
}
