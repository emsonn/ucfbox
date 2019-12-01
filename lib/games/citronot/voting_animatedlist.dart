import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:ucfbox/game_data.dart' as game_data;
//import 'package:ucfbox/games/citronot/leaderboard.dart';
import 'package:ucfbox/games/citronot/waiting_room.dart';
import 'package:ucfbox/models/players/citronot_player.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AnimatedListSample extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  CitronotPlayer player;
  DatabaseReference answerRef;
  DatabaseReference fact;
  int flag = 0;

  @override
  void initState() {
    super.initState();
    answerRef = game_data.gameRoom.child('answers');
    fact = game_data.gameRoom.child('fact');

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
                  stream: game_data.gameRoom.child('prompt').onValue,
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
                            if (game_data.player.key !=
                                snapshot.value['playerKey']) {

                              if (snapshot.value['correct'] == true) {

                                flag = 1;
                                Alert(
                                  closeFunction: () =>
                                    Navigator
                                      .push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WaitingRoom())),
                                  context: context,
                                  type: AlertType.success,
                                  title: "Good job!",
                                  desc:
                                  "You chose the correct answer!",
                                  buttons: [
                                    DialogButton(
                                      color: Color.fromRGBO(225, 202, 6, 100),
                                      child: Text(
                                        "CHARGE ON!",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
//                                      onPressed: () => Navigator.pop(context),
//                                      width: 120,

                                        onPressed: () =>
                                          Navigator
                                              .push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => WaitingRoom())),


                                    )
                                  ],
                                ).show();

                                await game_data.player
                                    .child('score')
                                    .runTransaction((transaction) async {
                                  transaction.value =
                                      (transaction.value ?? 0) + 20;
                                  return transaction;
                                });
                              }


                              else {
                                flag = 1;
                                Alert(
                                  context: context,
                                  type: AlertType.error,
                                  title: "Oh no!",
                                  desc:
                                  "You chose the wrong answer, better luck next time!",
                                  buttons: [
                                    DialogButton(
                                      color: Color.fromRGBO(225, 202, 6, 100),
                                      child: Text(
                                        "CHARGE ON!",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
//                                      onPressed: () => Navigator.pop(context),
//                                        width: 120,
                                    onPressed: () =>
                                      Navigator
                                    .push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WaitingRoom())),

                                    )


                                  ],
                                ).show();

                                await game_data.gameRoom
                                    .child('players')
                                    .child(snapshot.value['playerKey'])
                                    .child('score')
                                    .runTransaction((transaction) async {
                                  transaction.value =
                                      (transaction.value ?? 0) + 10;
                                  return transaction;
                                });
                              }

                              // Update Answer Count
                              // Update Users who have answered
                              final TransactionResult result = await game_data
                                  .gameRoom
                                  .child('answerCount')
                                  .runTransaction((transaction) async {
                                transaction.value =
                                    (transaction.value ?? 0) + 1;
                                return transaction;
                              });

                              if (result.committed) {

                                if (flag == 0)
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WaitingRoom()));
                                }

                              }
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
