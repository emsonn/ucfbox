//import 'package:flutter/material.dart';
//import 'package:ucfbox/my_app_bar.dart';
//import 'package:ucfbox/games/citronot/howtoplay.dart';
//import 'package:ucfbox/games/citronot/question.dart';
//
//class Citronot extends StatefulWidget {
//  @override
//  _CitronotState createState() => _CitronotState();
//}
//
//class _CitronotState extends State<Citronot> {
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      backgroundColor: Color(0xFFFFC904),
//      appBar: MyAppBar(),
//      body: SafeArea(
//        child: Column(
//          children: <Widget>[
//            /// Logo
//            Expanded(
//              flex: 5,
//              child: Image.asset(
//                'images/citronot.png',
//              ),
//            ),
//
//            /// List of players
//            Expanded(
//              flex: 3,
//              child: Text(
//                'PLAYERS',
//                textAlign: TextAlign.center,
//                style: TextStyle(
//                  fontSize: 25,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//            ),
//            SizedBox(
//              height: 60,
//            ),
//
//            /// How to play button
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
//            /// Start Game Button
//            Expanded(
//              flex: 0,
//              child: RaisedButton(
//                textColor: Color(0xFFFFC904),
//                color: Colors.black,
//                child: Text(
//                  'Start Game',
//                  style: TextStyle(
//                    fontSize: 20,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//                onPressed: () {
//                   Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => Question()));
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
//
//// class Citronot extends StatelessWidget {
////   @override
////   Widget build(BuildContext context) {
////     return new MaterialApp(home: CitronotHomeScreen());
////   }
//// }
//
//// class CitronotHomeScreen extends StatelessWidget {
////   @override
////   Widget build(BuildContext context) {
////     return new Scaffold(
////       backgroundColor: Color(0xFFFFC904),
////       appBar: MyAppBar(),
//
////       body: SafeArea(
////         child: Column(
////           children: <Widget>[
////             Expanded(
////               flex: 0,
////               child: Image.asset(
////                 'images/citronot.png',
////               ),
////             ),
//
////             Expanded(
////               flex: 3,
////               child: Text(
////                 'PLAYERS',
////                 textAlign: TextAlign.center,
////                 style: TextStyle(
////                   fontSize: 25,
////                   fontWeight: FontWeight.bold,
////                 ),
////               ),
////             ),
////             SizedBox(
////               height: 60,
////             ),
////             Expanded(
////               flex: 0,
////               child: RaisedButton(
////                 textColor: Color(0xFFFFC904),
////                 color: Colors.black,
////                 child: Text(
////                   'How to Play',
////                   style: TextStyle(
////                     fontSize: 20,
////                     fontWeight: FontWeight.bold,
////                   ),
////                 ),
////                 onPressed: () {
////                   Navigator.push(context,
////                       MaterialPageRoute(builder: (context) => HowToPlay()));
////                 },
////               ),
////             ),
////             SizedBox(
////               height: 10,
////             ),
//
////             Expanded(
////               flex: 0,
////               child: RaisedButton(
////                 textColor: Color(0xFFFFC904),
////                 color: Colors.black,
////                 child: Text(
////                   'Start Game',
////                   style: TextStyle(
////                     fontSize: 20,
////                     fontWeight: FontWeight.bold,
////                   ),
////                 ),
////                 onPressed: () {
////                   print('Start Game button has been pressed');
////                 },
////               ),
////             ),
////             SizedBox(
////               height: 30,
////             ),
////           ],
////         ),
////       ),
////     );
////   }
//// }



import 'dart:async';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/models/game_rooms/citronot_room.dart';
import 'package:ucfbox/models/players/citronot_player.dart';
import 'package:ucfbox/my_app_bar.dart';
// import 'package:ucfbox/my_app_bar.dart';
import 'package:ucfbox/games/citronot/howtoplay.dart';
// import 'package:ucfbox/games/citronot/question.dart';
// import 'package:ucfbox/models/widgets/playerlistview.dart';
import 'package:ucfbox/games/citronot/question.dart';

class Citronot extends StatefulWidget {
  @override
  _CitronotState createState() => new _CitronotState();
}

class _CitronotState extends State<Citronot> {
  List<CitronotPlayer> playerList = new List<CitronotPlayer>();
  CitronotPlayer player;
  DatabaseReference playerRef;
  DatabaseReference numPlayers;

  @override
  void initState() {
    super.initState();
    player = new CitronotPlayer("", 0, false, "");
    playerRef = game_data.gameRoom.child('players');
    numPlayers = game_data.gameRoom.child('noOfPlayers');
    playerRef.onChildAdded.listen(_onPlayerAdded);
    playerRef.onChildChanged.listen(_onPlayerChanged);
  }

  _onPlayerAdded(Event event) {
    setState(() {
      playerList.add(CitronotPlayer.fromSnapshot(event.snapshot));
      game_data.globalNumPlayers++;
    });
  }

  _onPlayerChanged(Event event) {
    var old = playerList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      playerList[playerList.indexOf(old)] =
          CitronotPlayer.fromSnapshot(event.snapshot);
    });
  }

  Color getColor(bool state) {

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFFFC904),
      appBar: MyAppBar(),

      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 2,

                child: Text('Game Room Code:\n ${game_data.gameRoom.key}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                ),


            ),
            Expanded(
              flex: 7,
              child: Image.asset(
                'images/citronot.png',
              ),
            ),

            Expanded(
              flex: 2,
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
              flex: 8,
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
                        )
                    );
                  }
              ),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Question()));
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