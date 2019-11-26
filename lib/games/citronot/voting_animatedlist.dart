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
  DatabaseReference playerRef;

  @override
  void initState() {
    super.initState();
    player = new CitronotPlayer("", 0, false, "");
    playerRef = game_data.gameRoom.child('players');
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
                  child: Text(
                    'This is a test to see how many characters should a player be able to see Also for when they input a answer to a question This is me adding x',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex:3,
                  child: FirebaseAnimatedList(
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
                            onTap: () async {
                              var score = ( await game_data.gameRoom.child('players').child(snapshot.key).once()).value['score'];
                              score += 10;
                              game_data.gameRoom.child('players').child(snapshot.key).child('score').set(score);
                            },
                            child: SizedBox(
                              height: 128.0,
                              child: Card(
                                color: Colors.primaries[index % Colors.primaries.length],
                                child: Center(
                                  child: Text("${snapshot.value['answer']}"),
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
