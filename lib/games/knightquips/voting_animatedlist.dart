import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/games/citronot/howtoplay.dart';
import 'package:ucfbox/games/citronot/leaderboard.dart';
import 'package:ucfbox/games/citronot/waiting_room.dart';
import 'package:ucfbox/games/knightquips/waiting_room.dart';
import 'package:ucfbox/models/players/citronot_player.dart';

class KQuipsVoting extends StatefulWidget {
  @override
  _KQuipsVotingState createState() => _KQuipsVotingState();
}

class _KQuipsVotingState extends State<KQuipsVoting> {
  CitronotPlayer player;
  DatabaseReference answerRef;

  @override
  void initState() {
    super.initState();

    answerRef = game_data.gameRoom.child('questions').child(game_data.needToVoteFor.last).child('answers');

    // Set next room
    game_data.nextRoom = game_data.NextRoom.leaderboard;
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
              child: new StreamBuilder<Event>(
                  stream: game_data.gameRoom.child('questions').child(game_data.needToVoteFor.last).child('prompt').onValue,
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
                            fontWeight: FontWeight.bold),
                      ));
                    }
                    return new Center(
                        child: Text(
                      'Loading...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ));
                  }),
            ),
            Expanded(
              flex: 3,
              child: FirebaseAnimatedList(
                  sort: (a, b) {
                    return a.value['answer']
                        .toString()
                        .toLowerCase()
                        .compareTo(b.value['answer'].toString().toLowerCase());
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
                                await game_data.gameRoom
                                    .child('players')
                                    .child(snapshot.value['playerKey'])
                                    .child('score')
                                    .runTransaction((transaction) async {
                                  transaction.value =
                                      (transaction.value ?? 0) + 10;
                                  return transaction;
                                });

                                game_data.needToVoteFor.removeLast();

                                if ( game_data.needToVoteFor.isNotEmpty) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => KQuipsVoting()));
                                }
                                else {
                                  // Update Answer Count
                                  // Update Users who have answered
                                  final TransactionResult transactionResult =
                                  await game_data
                                      .gameRoom
                                      .child('answerCount')
                                      .runTransaction((transaction) async {
                                    transaction.value = (transaction.value ?? 0 ) + 1;
                                    return transaction;
                                  });
                                  game_data.kQuipsRooms = game_data.KQuipsRooms.leaderboard;
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => KQuipsWaitingRoom()));
                                }
                          },
                          child: SizedBox(
                            height: 128.0,
                            child: Card(
                              color: Colors.black,
                              child: Center(
                                child: Text(
                                  "${snapshot.value['answer']}",
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
          ]),
        ),
      ),
    );
  }
}
