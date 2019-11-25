import 'package:flutter/material.dart';
import 'package:ucfbox/models/players/knightquips_player.dart';
import 'package:ucfbox/my_app_bar.dart';
import 'package:ucfbox/games/knightquips/howtoplay.dart';
//import 'package:ucfbox/games/knightquips/question.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;

//import 'package:ucfbox/models/game_rooms/knightquips_room.dart';

class KnightQuips extends StatefulWidget {
  @override
  _KQState createState() => new _KQState();
}

class _KQState extends State<KnightQuips> {
  List<KnightQuipsPlayer> playerList = new List<KnightQuipsPlayer>();
  KnightQuipsPlayer player;
  DatabaseReference playerRef;

  @override
  void initState() {
    super.initState();
    player = new KnightQuipsPlayer("", 0, false);
    playerRef = game_data.gameRoom.child('players');
    playerRef.onChildAdded.listen(_onPlayerAdded);
    playerRef.onChildChanged.listen(_onPlayerChanged);
  }

  _onPlayerAdded(Event event) {
    setState(() {
      playerList.add(KnightQuipsPlayer.fromSnapshot(event.snapshot));
    });
  }

  _onPlayerChanged(Event event) {
    var old = playerList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      playerList[playerList.indexOf(old)] =
          KnightQuipsPlayer.fromSnapshot(event.snapshot);
    });
  }

  Color getColor(bool state) {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFFFC904),
      appBar: MyAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Text(
                  '${game_data.gameRoom.key}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Expanded(
              flex: 8,
              child: Image.asset(
                'images/knightquips.png',
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'PLAYERS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: new FirebaseAnimatedList(
                  query: playerRef,
                  itemBuilder: (_, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    return new Material(
                        color: snapshot.value['start'] == true
                            ? Colors.green
                            : Colors.white,
                        child: ListTile(
                          title: new Text(snapshot.value['playerName']),
                        ));
                  }),
            ),
            Expanded(
              flex: 0,
              child: RaisedButton(
                textColor: Color(0xFFFFC904),
                color: Colors.black,
                child: Text(
                  'How to Play',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HowToPlay()));
                },
              ),
            ),
            Expanded(
              flex: 0,
              child: RaisedButton(
                textColor: Color(0xFFFFC904),
                color: Colors.black,
                child: Text(
                  'Start Game',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  print('Start Game button has been pressed');
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

//void Quiplash() => runApp(KnightQuips());

//class KnightQuips extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//        home: KnightQuipsHomeScreen());
//  }
//}

//class KnightQuipsHomeScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      backgroundColor: Color(0xFFFFC904),
//      appBar: MyAppBar(),
////
////        )),
//      body: Center(
//        child: Column(
//
//          children: <Widget>[
//            Expanded(
//              flex: 3,
//              child: Image.asset(
//                'images/knightquips.png',
//              ),
//            ),
//
//            Expanded(
//              flex:3,
//              child: Text(
//                'PLAYERS',
//                textAlign: TextAlign.center,
//                style: TextStyle(
//                  fontSize: 25,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//            ),
//
//            SizedBox(
//              height: 60,
//            ),
//            Expanded(
//              flex: 0,
//              child: RaisedButton(
//                textColor: Color(0xFFFFC904),
//                color: Colors.black,
//                child: Text(
//                  'How to Play',
//                  style: TextStyle(
//                    fontSize: 20,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => HowToPlay()));
//                },
//              ),
//            ),
//            SizedBox(
//              height: 10,
//            ),
//
//            Expanded(
//              flex: 0,
//              child: RaisedButton(
//                textColor: Color(0xFFFFC904),
//
//                color: Colors.black,
//                child: Text(
//                  'Start Game',
//                  style: TextStyle(
//                    fontSize: 20,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//                onPressed: () {
//                  print('Start Game button has been pressed');
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => QAndAScreen()));
//                },
//              ),
//            ),
//            SizedBox(
//              height: 30,
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
