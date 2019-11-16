import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/models/players/knightquips_player.dart';

class KnightQuips extends StatefulWidget {
  @override
  _KnightQuipsState createState() => _KnightQuipsState();
}

  class _KnightQuipsState extends State<KnightQuips> {
    @override
    void initState() {
      super.initState();
      FirebaseDatabase.instance.reference().onChildAdded.listen(_onEntryAdded);
    }

    _onEntryAdded(Event event) {
      KnightQuipsPlayer test =
        new KnightQuipsPlayer.fromSnapshot(event.snapshot);
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
                  KnightQuipsPlayer('kqplayer', 0, false)
                      .toJson());
            },
          ),
          FlatButton(
            child: Text('map'),
            color: Colors.white,
            onPressed: () {
              FirebaseDatabase.instance.reference().push().set(
                  KnightQuipsPlayer('kqplayer', 0, false)
                      .toJson());
            },
          )
        ],
      ),
    );
  }
}
