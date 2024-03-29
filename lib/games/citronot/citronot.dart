import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/models/answers/citronot_answer.dart';
import 'package:ucfbox/models/players/citronot_player.dart';
import 'package:ucfbox/games/citronot/howtoplay.dart';
import 'package:ucfbox/games/citronot/question.dart';
import 'package:ucfbox/home_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ucfbox/my_app_bar.dart';

class Citronot extends StatefulWidget {
  @override
  _CitronotState createState() => new _CitronotState();
}

class _CitronotState extends State<Citronot> {
  List<CitronotPlayer> playerList = new List<CitronotPlayer>();
  CitronotPlayer player;
  DatabaseReference playerRef;
  var listen1;
  var listen2;
  var listen3;
  var nextRoomListener;

  @override
  void initState() {
    super.initState();
    player = new CitronotPlayer("", 0, false, "");
    playerRef = game_data.gameRoom.child('players');
    listen1 = playerRef.onChildAdded.listen(_onPlayerAdded);
    listen2 = playerRef.onChildChanged.listen(_onPlayerChanged);

    // Ready
    listen3 = game_data.gameRoom.child('answerCount').onValue.listen(_onCountChanged);

    // Setup Gamewide Game leave room listern for host, DO NOT DISPOSE!!!
    // This should probably be set up elsewhere when we have time
    if (game_data.status == game_data.Status.host)
      nextRoomListener = game_data.gameRoom.child('nextRoom').onValue.listen(_onNext);
  }

  _onNext(Event event) async {
    if ((await game_data.gameRoom.once()).value['noOfPlayers'] ==
        (await game_data.gameRoom.once()).value['nextRoom']){
      game_data.gameRoom.child('nextRoom').set(0);
      game_data.gameRoom.child('answerCount').set(0);
    }
  }

  _onCountChanged(Event event) async{
    if ((await game_data.gameRoom.once()).value['answerCount'] ==
        (await game_data.gameRoom.once()).value['noOfPlayers'])
      {
        game_data.globalNumPlayers = ( await game_data.gameRoom.once()).value['noOfPlayers'];

        final TransactionResult result =
          await game_data.gameRoom.child('nextRoom').runTransaction((transaction) async {
            transaction.value = (transaction.value ?? 0 ) + 1;
            return transaction;
          });

        if (result.committed) {
          listen1.cancel();
          listen2.cancel();
          listen3.cancel();

          // Set var back to false
          var myPlayer = CitronotPlayer.fromSnapshot(
              await game_data.player.once());
          myPlayer.start = false;
          game_data.player.set(myPlayer.toJson());

          // Continue
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Question()));
        }
      }
  }

  _onPlayerAdded(Event event) {
    setState(() {
      playerList.add(CitronotPlayer.fromSnapshot(event.snapshot));
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

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Color(0xFFFFC904),
      appBar: MyAppBar(),
      //AppBar(

      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   actions: <Widget>[

      //     IconButton(
      //         icon: Icon(Icons.home),
      //         onPressed: () async {
      //           game_data.player.remove();
      //           var result = await game_data.gameRoom.child('noOfPlayers').runTransaction((transaction) async {
      //             transaction.value = (transaction.value ?? 0 ) - 1;
      //             return transaction;
      //           });
      //           Navigator.popUntil(
      //               context, ModalRoute.withName(Navigator.defaultRouteName));

      //           playerList.length = result.dataSnapshot.value;
      //           if(playerList.length == 0)
      //           {
      //             game_data.gameRoom.remove();
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => HomePage()));
      //           }
      //         })
      //   ],

      // leading: new Container(),

      // ),

      body: SafeArea(
        child: Column(
          children: <Widget>[

            Expanded(
              flex: 3,
              child: Image.asset(
                'images/citronot.png',
              ),
            ),
            Expanded(
              flex: 4,

              child: Text('Game Room Code:\n ${game_data.gameRoom.key}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
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
              flex: 8,
              child: new FirebaseAnimatedList(
                  query: playerRef,
                  itemBuilder: (_, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    if (snapshot == null ) {
                      return SizedBox(height: 10,);
                    }
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

                  /// Change this back to How to Play!!!
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
                onPressed: () async {
                  if ((playerList.length < game_data.citronotMinNumPlayers) || 
                      (playerList.length > game_data.citronotMaxNumPlayers)) {
                      Alert(
                              context: context,
                              type: AlertType.error,
                              title: "UCFBox Alert",
                              desc: "${game_data.citronotMinNumPlayers} to ${game_data.citronotMaxNumPlayers} players required - sorry!",
                              buttons: [
                                DialogButton(
                                  color: Color.fromRGBO(225, 202, 6, 100),
                                  child: Text(
                                    "CHARGE ON!",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                )
                              ],
                            ).show();
                  }

                  else {
                    game_data.citronotNumRounds = 2;

                    // Download Q/As
                    if ( game_data.status == game_data.Status.host ) {
                      game_data.questionBank = await Firestore.instance.collection('citronot').getDocuments();

                      game_data.deck = new List<int>();
                      
                      // Will randomly generate 3 different question indices for lookup.
                      while (game_data.deck.length < 3) {
                        var randomQuestionIndex = new Random();
                        game_data.deck.add(randomQuestionIndex.nextInt((game_data.citronotNumQuestions)));
                        game_data.deck.toSet().toList();
                      }
                      
                      var prompt = game_data.questionBank.documents[game_data.question][game_data.deck.last.toString()];

                      game_data.gameRoom.child('prompt').set(prompt);

                      var answer = game_data.questionBank.documents[game_data.answer][game_data.deck.removeLast().toString()];
                      var correctAnswer = new CitronotAnswer("", answer, correct: true);
                      
                      game_data.gameRoom.child('fact').set(answer.toString());

                      var answerRef = game_data.gameRoom.child('answers').push();
                      answerRef.set(correctAnswer.toJson());
                    }

                    // Update Player
                    var myPlayer = CitronotPlayer.fromSnapshot(
                        await game_data.player.once());
                    myPlayer.start = true;
                    game_data.player.set(myPlayer.toJson());

                    // Update Users who have answered
                    await game_data.gameRoom.child('answerCount').runTransaction((transaction) async {
                      transaction.value = (transaction.value ?? 0 ) + 1;
                      return transaction;
                    });
                  } // end of else
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
