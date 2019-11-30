import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/games/night_night_knightro/how_to_play.dart';
import 'package:ucfbox/games/night_night_knightro/role_assignment.dart';
import 'package:ucfbox/models/players/nightNightKnightro_player.dart';
import 'package:ucfbox/game_data.dart' as game_data;

class NightNightKnightro extends StatefulWidget {
  @override
  _NightNightKnightroState createState() => _NightNightKnightroState();
}

class _NightNightKnightroState extends State<NightNightKnightro> {
  NightNightKnightroPlayer player;
  Map<String, NightNightKnightroPlayer> players;
  int randomSeed;

  @override
  void initState() {
    super.initState();
    players = new Map();
    game_data.player.once().then((DataSnapshot snapshot) {
      player = NightNightKnightroPlayer.fromSnapshot(snapshot);
    });
    randomSeed = players.length - 1;
    game_data.gameRoom.child('players').onChildAdded.listen(_onPlayerAdded);
    game_data.gameRoom.child('players').onChildChanged.listen(_onPlayersUpdate);
  }

  _onPlayerAdded(Event event) {
    print('onPlayerAdded');
    if (players != null) {
      players.putIfAbsent(event.snapshot.key, () {
        return NightNightKnightroPlayer.fromSnapshot(event.snapshot);
      });
      setState(() {
        players = players;
      });
    }
  }

  _onPlayersUpdate(Event event) {
    setState(() {
      players[event.snapshot.key].start = !players[event.snapshot.key].start;
    });
    var starts = 0;
    players.forEach((k, v) => {v.start ? starts++ : null});
    if (starts == players.length) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RoleAssignment()),
      );
    }
  }

  _onPlayerStart(Event event) {}

  handleStart() {
    game_data.player.update({'start': !player.start});
    setState(() {
      player.start = !player.start;
    });
//    game_data.player.once().then((DataSnapshot snapshot) {
//      print(snapshot.value);
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Image.asset(
              'images/nightNightKnightroSplash.png',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                'game code: ${game_data.gameRoom.key}',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Press Start 2P'),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1)),
              width: 300,
              height: 60,
              child: GridView.count(
                  childAspectRatio: 7 / 1,
                  crossAxisCount: 2,
                  children: List.generate(players.length, (index) {
                    return Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                              '${index + 1}. ${players[players.keys.toList()[index]].playerName}',
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Press Start 2P',
                                  fontSize: 8)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: players[players.keys.toList()[index]].start
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
            ),
            FlatButton(
              child: Text(
                'Start',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Press Start 2P'),
              ),
              onPressed: () {
                handleStart();
              },
            ),
            FlatButton(
              child: Text(
                'How to Play',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Press Start 2P'),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HowToPlay()));
              },
            )
          ],
        ),
      ),
    );
  }
}
