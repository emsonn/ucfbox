import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/games/night_night_knightro/special_role.dart';
import 'package:ucfbox/models/game_rooms/nightNightKnightro_room.dart';
import 'package:ucfbox/game_data.dart' as game_data;

class VotingRoom extends StatefulWidget {
  @override
  _VotingRoomState createState() => _VotingRoomState();
}

class _VotingRoomState extends State<VotingRoom> {
  bool buttonDisabled = false;
  StreamSubscription listener;

  @override
  void initState() {
    super.initState();

    listener = game_data.gameRoom.onValue.listen(_onRoomUpdate);
  }

  _onRoomUpdate(Event event) {
    if (event.snapshot.value['voteCount'] ==
        event.snapshot.value['players'].length) {
      int highest = 0;
      String killed;
      event.snapshot.value['players'].forEach((k, v) {
        if (v['votes'] > highest) {
          killed = k;
          highest = v['votes'];
        }
      });

      game_data.gameRoom.update({'killed': killed});

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SpecialRole()));
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Who is Knightro?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Press Start 2P',
                    fontSize: 20),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: StreamBuilder(
                    stream: game_data.gameRoom.onValue,
                    builder: (context, snap) {
                      if (snap.hasData && !snap.hasError) {
                        NightNightKnightroRoom room =
                            NightNightKnightroRoom.fromSnapshot(
                                snap.data.snapshot);
                        return buttonDisabled
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Waiting for other players',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Press Start 2P',
                                        fontSize: 8),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    'images/loadingEllipsis.gif',
                                    scale: 1.4,
                                  )
                                ],
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: room.players.length,
                                itemBuilder: (context, index) {
                                  return FlatButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      game_data.gameRoom
                                          .child('players')
                                          .child(
                                              room.players.keys.toList()[index])
                                          .update({
                                        'votes': room
                                                .players[room.players.keys
                                                    .toList()[index]]
                                                .votes +
                                            1
                                      });
                                      game_data.gameRoom.update(
                                          {'voteCount': room.voteCount + 1});
                                      setState(() {
                                        buttonDisabled = true;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          room
                                              .players[room.players.keys
                                                  .toList()[index]]
                                              .playerName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Press Start 2P'),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                      }
                      return Container();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
