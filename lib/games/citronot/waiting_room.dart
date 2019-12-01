import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/games/citronot/howtoplay.dart';
import 'package:ucfbox/models/players/citronot_player.dart';
import 'package:ucfbox/my_app_bar.dart';
import 'package:ucfbox/games/citronot/voting_animatedlist.dart';
import 'package:ucfbox/games/citronot/results.dart';
import 'package:ucfbox/games/citronot/question.dart';
import 'package:ucfbox/models/answers/citronot_answer.dart';

class WaitingRoom extends StatefulWidget {
  @override
  _WaitingState createState() => new _WaitingState();
}

class _WaitingState extends State<WaitingRoom> {
  List<CitronotPlayer> playerList = new List<CitronotPlayer>();
  DatabaseReference playerRef;
  var listen1;
  var listen2;

  @override
  void initState() {
    super.initState();

    game_data.player.child('start').set(true);

    playerRef = game_data.gameRoom.child('players');

    listen1 = playerRef.onChildChanged.listen(_onPlayerChanged);
    listen2 = game_data.gameRoom.child('answerCount').onValue.listen(_onCountChanged);

    // Setup next round
    if (game_data.status == game_data.Status.host && game_data.nextRoom == game_data.NextRoom.question){
      game_data.gameRoom.child('answers').remove();

      var prompt = game_data.questionBank.documents[game_data.question][game_data.deck.last.toString()];
      game_data.gameRoom.child('prompt').set(prompt);
                      
      var answer = game_data.questionBank.documents[game_data.answer][game_data.deck.removeLast().toString()];
      game_data.gameRoom.child('fact').set(answer.toString());

      var correctAnswer = new CitronotAnswer("", answer, correct: true);
      var answerRef = game_data.gameRoom.child('answers').push();
      answerRef.set(correctAnswer.toJson());
    }
  }

  _onCountChanged(Event event) async{
    if ((await game_data.gameRoom.once()).value['answerCount'] ==
        (await game_data.gameRoom.once()).value['noOfPlayers'])
    {

      listen1.cancel();
      listen2.cancel();
      /// Make a Results.Dart

      game_data.player.child('start').set(false);

      // Update Users who have answered
      await game_data.gameRoom.child('nextRoom').runTransaction((transaction) async {
        transaction.value = (transaction.value ?? 0) + 1;
        return transaction;
      });

      if (game_data.nextRoom == game_data.NextRoom.voting) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AnimatedListSample()));
        }
      else if (game_data.nextRoom == game_data.NextRoom.leaderboard){
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Results()));
      }
      else if( game_data.nextRoom == game_data.NextRoom.question) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Question()));
      }
    }
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
              flex: 2,
              child: Text(
                'Waiting on these Players...',
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
                            : Colors.red,
                        child: ListTile(
                          title: new Text(snapshot.value['playerName']),

                        ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
