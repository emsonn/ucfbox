import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/games/night_night_knightro/lose_room.dart';
import 'package:ucfbox/games/night_night_knightro/voting_room.dart';
import 'package:ucfbox/games/night_night_knightro/win_room.dart';
import 'package:ucfbox/models/game_rooms/nightNightKnightro_room.dart';

class KilledRoom extends StatefulWidget {
  @override
  _KilledRoomState createState() => _KilledRoomState();
}

class _KilledRoomState extends State<KilledRoom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Container(
            child: FutureBuilder(
              future: game_data.gameRoom.once(),
              builder: (context, snap) {
                if (snap.data != null) {
                  NightNightKnightroRoom room =
                      NightNightKnightroRoom.fromSnapshot(snap.data);
                  game_data.gameRoom
                      .child('players')
                      .child(room.killed)
                      .update({'alive': false});
                  game_data.gameRoom
                      .update({'noOfPlayers': room.noOfPlayers - 1});

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          'During the night\n\n${room.players[room.killed].playerName}\n\nwas killed',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Press Start 2P')),
                      SizedBox(height: 50),
                      Text(
                          room.players[room.killed].role == 'knightro'
                              ? 'They were Knightro'
                              : 'They were NOT Knightro',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:
                                  room.players[room.killed].role == 'knightro'
                                      ? Colors.green
                                      : Colors.red,
                              fontFamily: 'Press Start 2P')),
                      FlatButton(
                        onPressed: () {
                          game_data.gameRoom
                              .child('noOfPlayers')
                              .once()
                              .then((DataSnapshot snapshot) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => snapshot.value < 3
                                        ? LoseRoom()
                                        : VotingRoom()));
                          });
                        },
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Okay',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Press Start 2P')),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              'images/blinkingCursor.gif',
                              scale: .5,
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
