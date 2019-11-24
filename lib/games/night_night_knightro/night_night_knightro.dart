import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/models/game_rooms/nightNightKnightro_room.dart';
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
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
            child: Text('push'),
            color: Colors.white,
            onPressed: () {
              game_data.gameRoom.once().then((DataSnapshot snapshot) {
                NightNightKnightroRoom room =
                    NightNightKnightroRoom.fromSnapshot(snapshot);
                players = room.players;
              });
            },
          ),
          FlatButton(
            child: Text('map'),
            color: Colors.white,
            onPressed: () {
              game_data.gameRoom.once().then((DataSnapshot snapshot) {
                NightNightKnightroRoom room =
                    NightNightKnightroRoom.fromSnapshot(snapshot);
              });
            },
          )
        ],
      ),
    );
  }
}
