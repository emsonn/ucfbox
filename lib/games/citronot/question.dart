import 'package:flutter/material.dart';
import 'package:ucfbox/games/citronot/player_input.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/internert_check/network_sensitive.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => new _QuestionState();
}

class _QuestionState extends State<Question> {
  String roundPrompt;

  Future<String> getPrompt() async {
    var roomRef = game_data.gameRoom.once();
    roomRef.then((snapshot) {
      roundPrompt = snapshot.value['prompt'];
    });
    return roundPrompt;
  }

  @override
  void initState() {
    super.initState();

    game_data.nextRoom = game_data.NextRoom.voting;
  }

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: Scaffold(
        backgroundColor: Colors.black,

        /// Container
        body: SafeArea(
          child: Container(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 30),

                /// Question is displayed
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFC904),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: new StreamBuilder<Event>(
                        stream: game_data.gameRoom.child('prompt').onValue,
                        builder:
                            (BuildContext context, AsyncSnapshot<Event> event) {
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
                ),

                SizedBox(height: 100),

                /// Answer Button
                Expanded(
                  flex: 0,
                  child: RaisedButton(
                    color: Color(0xFFFFC904),
                    child: Text(
                      'Answer',
//                    textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => PlayerInput());
                    }, // OnPressed
                  ),
                ),

                SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
