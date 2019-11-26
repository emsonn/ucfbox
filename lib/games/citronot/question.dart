import 'package:flutter/material.dart';
import 'package:ucfbox/games/citronot/player_input.dart';
//import 'package:ucfbox/games/citronot/citronot.dart' as citronot;
import 'package:ucfbox/games/citronot/voting_animatedlist.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/games/citronot/citronot.dart';
import 'package:ucfbox/games/citronot/waiting_room.dart';

class Question extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Center(
                    child: Text(
                      'This is a test to see how many characters should a player be able to see Also for when they input a answer to a question This is me adding x',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                        context: context, builder: (context) => PlayerInput());
                  }, // OnPressed
                ),
              ),

              SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}
