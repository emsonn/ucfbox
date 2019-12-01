import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/models/game_rooms/nightNightKnightro_room.dart';

class KnightroRole extends StatefulWidget {
  @override
  _KnightroRoleState createState() => _KnightroRoleState();
}

class _KnightroRoleState extends State<KnightroRole> {
  bool buttonDisabled = false;
  List swapPlayers = new List();

  @override
  Widget build(BuildContext context) {
    swapPlayers = new List();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        children: <Widget>[
          Text('Choose two players for role swap',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontFamily: 'Press Start 2P')),
          SizedBox(height: 50),
          FutureBuilder(
              future: game_data.gameRoom.once(),
              builder: (context, snap) {
                if (snap.data != null) {
                  NightNightKnightroRoom room =
                      NightNightKnightroRoom.fromSnapshot(snap.data);
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
                                swapPlayers
                                    .add(room.players.keys.toList()[index]);
                                if (swapPlayers.length == 2) {
                                  game_data.gameRoom
                                      .child('players')
                                      .child(swapPlayers[0])
                                      .update({
                                    'role': room.players[swapPlayers[1]].role
                                  });
                                  game_data.gameRoom
                                      .child('players')
                                      .child(swapPlayers[1])
                                      .update({
                                    'role': room.players[swapPlayers[0]].role
                                  });
                                  game_data.gameRoom
                                      .child('voteCount')
                                      .once()
                                      .then((DataSnapshot snapshot) {
                                    print(snapshot.value);
                                    game_data.gameRoom.update(
                                        {'voteCount': snapshot.value + 1});
                                  });
                                  setState(() {
                                    buttonDisabled = true;
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                height: 50,
                                child: Center(
                                  child: Text(
                                    room
                                        .players[
                                            room.players.keys.toList()[index]]
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
        ],
      ),
    );
  }
}
