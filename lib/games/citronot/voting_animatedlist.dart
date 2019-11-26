import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/games/citronot/waiting_room.dart';
import 'package:ucfbox/models/players/citronot_player.dart';


class AnimatedListSample extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  CitronotPlayer player;
  DatabaseReference answerRef;

  @override
  void initState() {
    super.initState();
    answerRef = game_data.gameRoom.child('answers');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFFC904),
        body: SafeArea(
          child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: new StreamBuilder<Event>(
                      stream: game_data.gameRoom
                          .child('prompt')
                          .onValue,
                      builder: (BuildContext context, AsyncSnapshot<Event> event) {
                        if (event.data.snapshot.value != null) {
                          String prompt = event.data.snapshot.value;
                          return new Center(
                              child: Text(
                                '$prompt',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                          );
                        }
                        return new Center(
                            child: Text(
                              'Loading...',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                        );
                      }
                  ),
                ),
                Expanded(
                  flex:3,
                  child: FirebaseAnimatedList(
                    sort: (a, b) {
                      return a.value['answer'].toString().toLowerCase().compareTo(b.value['answer'].toString().toLowerCase());
                      },
                    query: answerRef,
                    itemBuilder: (_, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SizeTransition(
                          axis: Axis.vertical,
                          sizeFactor: animation,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              var playerKey = ( await game_data.gameRoom.child('answers').child(snapshot.key).once()).value['playerKey'];
                              var score = ( await game_data.gameRoom.child('players').child(playerKey).once()).value['score'];

                              if ( game_data.player.key != playerKey ){

                                if ( snapshot.value['correct'] == true ){
                                  score = score + 10;
                                  game_data.player.set(score);
                                }
                                else{
                                  score = score + 10;
                                  game_data.gameRoom.child('players').child(playerKey).child('score').set(score);
                                }

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => WaitingRoom()));
                              }

                            },
                            child: SizedBox(
                              height: 128.0,
                              child: Card(
                                color: Colors.black,
                                child: Center(
                                  child: Text("${snapshot.value['answer']}",
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
                    }
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
