import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ucfbox/game_data.dart';
import 'package:ucfbox/games/citronot/voting_animatedlist.dart';
import 'package:ucfbox/games/knightquips/waiting_room.dart';
import 'package:ucfbox/models/answers/citronot_answer.dart';
import 'package:ucfbox/models/players/citronot_player.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/games/citronot/waiting_room.dart';
import 'package:ucfbox/games/knightquips/question.dart';

class KQuipsPlayerInput extends StatefulWidget {
  @override
  _KQuipsPlayerInputState createState() => _KQuipsPlayerInputState();
}

class _KQuipsPlayerInputState extends State<KQuipsPlayerInput> {
  String userInput;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff654a07),

      /// Card
      child: Container(
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Enter Your Answer',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            /// Where the player enters their answer
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              maxLength: 140,
              inputFormatters: [LengthLimitingTextInputFormatter(140),],
              onChanged: (input) {
                print('$input');
                userInput = input;
              },
            ),
            SizedBox(height: 20),

            /// Submit Answer Button
            FlatButton(
              color: Colors.black,
              child: Text('Submit',
                  style: TextStyle(
                      color: Color(0xFFFFC904),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  )),
              onPressed: () async {
                print('The user input is the following: $userInput');

                // Update my Answer
                var myAnswer = new CitronotAnswer(game_data.player.key, userInput);

                if(game_data.kQuipsRooms == game_data.KQuipsRooms.question1) {
                  var answerRef = game_data.gameRoom.child('questions').child(game_data.question1).child('answers').push();
                  answerRef.set(myAnswer.toJson());
                }
                else if (game_data.kQuipsRooms == game_data.KQuipsRooms.question2) {
                  var answerRef = game_data.gameRoom.child('questions').child(game_data.question2).child('answers').push();
                  answerRef.set(myAnswer.toJson());
                }

                if ( game_data.kQuipsRooms == game_data.KQuipsRooms.question1) {
                  game_data.kQuipsRooms = game_data.KQuipsRooms.question2;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KQuipsQuestion()));
                }
                else {
                  /// WARNING THIS IS ONLY A TEMPORARY FIX!!!
                  game_data.gameRoom.child('nextRoom').set(0);


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
                  game_data.kQuipsRooms = game_data.KQuipsRooms.voting;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KQuipsWaitingRoom()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
