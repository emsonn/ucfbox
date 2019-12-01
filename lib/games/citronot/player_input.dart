import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:ucfbox/games/citronot/voting_animatedlist.dart';
import 'package:ucfbox/models/answers/citronot_answer.dart';
//import 'package:ucfbox/models/players/citronot_player.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/games/citronot/waiting_room.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ucfbox/internert_check/network_sensitive.dart';

class PlayerInput extends StatefulWidget {
  @override
  _PlayerInputState createState() => _PlayerInputState();
}

class _PlayerInputState extends State<PlayerInput> {
  String userInput;

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: Container(
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(140),
                ],
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
                        fontWeight: FontWeight.bold)),
                onPressed: () async {
                  print('The user input is the following: $userInput');
                  String roundActualAnswer =
                      (await game_data.gameRoom.once()).value['fact'];
                  print("Correct answer? $roundActualAnswer");

                  if (userInput.length == 0) {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "UCFBox Alert",
                      desc: "Cannot enter a blank answer. Please try again.",
                      buttons: [
                        DialogButton(
                          color: Color.fromRGBO(225, 202, 6, 100),
                          child: Text(
                            "CHARGE ON!",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                    ).show();
                  }

                  // Condition for player entering in the same answer as the round's fact
                  else if (userInput.toLowerCase() ==
                      roundActualAnswer.toLowerCase()) {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "UCFBox Alert",
                      desc: "Enter in a different answer, please!",
                      buttons: [
                        DialogButton(
                          color: Color.fromRGBO(225, 202, 6, 100),
                          child: Text(
                            "CHARGE ON!",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                    ).show();
                  }
                  // Normal condition where the round's correct answer has not been input + submitted
                  else {
                    if ((await game_data.gameRoom.once()).value['nextRoom'] ==
                        0) {
                      // Update my Answer
                      var myAnswer =
                          new CitronotAnswer(game_data.player.key, userInput);
                      var answerRef =
                          game_data.gameRoom.child('answers').push();
                      answerRef.set(myAnswer.toJson());

                      // Update Answer Count
                      // Update Users who have answered
                      final TransactionResult transactionResult =
                          await game_data.gameRoom
                              .child('answerCount')
                              .runTransaction((transaction) async {
                        transaction.value = (transaction.value ?? 0) + 1;
                        return transaction;
                      });

                      if (transactionResult.committed)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WaitingRoom()));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
