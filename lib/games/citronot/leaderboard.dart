import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/home_page.dart';
//import 'package:ucfbox/games/citronot/waiting_room.dart';
import 'package:ucfbox/models/players/citronot_player.dart';
import 'package:ucfbox/games/citronot/question.dart';

class Leaderboard extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<Leaderboard> {
  CitronotPlayer player;
  DatabaseReference playerRef;

  @override
  void initState() {
    super.initState();
    playerRef = game_data.gameRoom.child('players');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFFC904),
        body: SafeArea(
          child: Column(children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Expanded(
                child: Text(
              'LEADERBOARD',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
            )),
            Expanded(
              flex: 9,
              child: FirebaseAnimatedList(
                  sort: (a, b) {
                    return a.value['score'].compareTo(b.value['score']);
                  },
                  query: playerRef,
                  itemBuilder: (_, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SizeTransition(
                        axis: Axis.vertical,
                        sizeFactor: animation,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: SizedBox(
                            height: 128.0,
                            child: Card(
                              color: Colors.black,
                              child: Center(
                                child: Text(
                                  "${snapshot.value['playerName']}   Score:${snapshot.value['score']}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFFFC904),
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),

            Expanded(
              flex: 0,
              child: RaisedButton(
                textColor: Color(0xFFFFC904),
                color: Colors.black,
                child: Text(
                  'End Game',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ),


          ]),
        ),
      ),
    );
  }
}
