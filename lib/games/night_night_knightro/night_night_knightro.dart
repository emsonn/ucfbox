import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/models/players/nightNightKnightro_player.dart';

class NightNightKnightro extends StatefulWidget {
  @override
  _NightNightKnightroState createState() => _NightNightKnightroState();
}

class _NightNightKnightroState extends State<NightNightKnightro> {
  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.reference().onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {
    NightNightKnightroPlayer test =
        new NightNightKnightroPlayer.fromSnapshot(event.snapshot);
    print(test.playerName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
            child: Text('push'),
            color: Colors.white,
            onPressed: () {
              FirebaseDatabase.instance.reference().push().set(
                  NightNightKnightroPlayer(true, 'kelly', 'knightro', false, 0)
                      .toJson());
            },
          ),
          FlatButton(
            child: Text('map'),
            color: Colors.white,
            onPressed: () {
              FirebaseDatabase.instance.reference().push().set(
                  NightNightKnightroPlayer(true, 'kelly', 'knightro', false, 0)
                      .toJson());
            },
          )
        ],
      ),
    );
  }
}
