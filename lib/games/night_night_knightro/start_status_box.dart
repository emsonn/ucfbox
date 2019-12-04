import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/models/game_rooms/nightNightKnightro_room.dart';
import 'package:ucfbox/models/players/nightNightKnightro_player.dart';

class StartStatusBox extends StatefulWidget {
  @override
  _StartStatusBoxState createState() => _StartStatusBoxState();
}

class _StartStatusBoxState extends State<StartStatusBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: game_data.gameRoom.onValue,
        builder: (context, snap) {
          if (snap.hasData && !snap.hasError) {
            NightNightKnightroRoom room =
                NightNightKnightroRoom.fromSnapshot(snap.data.snapshot);
            return Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1)),
              width: 300,
              height: 60,
              child: GridView.count(
                  childAspectRatio: 7 / 1,
                  crossAxisCount: 2,
                  children: List.generate(room.players.length, (index) {
                    return Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                              '${index + 1}. ${room.players[room.players.keys.toList()[index]].playerName}',
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Press Start 2P',
                                  fontSize: 8)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: room.players[room.players.keys.toList()[index]]
                                  .start
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 8,
                                )
                              : Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 8,
                                ),
                        ),
                      ],
                    );
                  })),
            );
          }
          return Text('loading');
        });
    ;
  }
}
