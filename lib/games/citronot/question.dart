import 'package:flutter/material.dart';
import 'package:ucfbox/games/citronot/player_input.dart';
//import 'package:ucfbox/games/citronot/citronot.dart' as citronot;
import 'package:ucfbox/games/citronot/voting_animatedlist.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/games/citronot/citronot.dart';
class Question extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// BUTTON WHERE THE USER CAN ENTER THE QUESTION.
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.question_answer, color: Color(0xff654a07)),
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => PlayerInput());
        },
      ),

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

              /// Start Button
              Expanded(
                flex: 0,
                child: RaisedButton(
                  color: Color(0xFFFFC904),
                  child: Text(
                    'Next',
//                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {

                    /// NEED TO ADD IF STATEMENT HERE TO SEE WHICH UI WILL BE USED
                    /// DEPENDING ON THE NUMBER OF PLAYERS WE HAVE

//
//           if (noOfPlayers 4) {
//             print('THIS IS WORKINGGGGKAKJDAKL');
//             Navigator.push(context,
//                 MaterialPageRoute(
//                     builder: (context) => FourPlayers()));
//           }
//           else if (game_data.globalNumPlayers == 5) {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => FivePlayers()));
//           }
//
//           else if (game_data.globalNumPlayers == 6) {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => SixPlayers()));
//           }
//
//           else if (game_data.globalNumPlayers == 7) {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => SevenPlayers()));
//           }
//
//           else if (game_data.globalNumPlayers == 8) {
//             Navigator.push(context,
////                 MaterialPageRoute(builder: (context) => EightPlayers()));
//           }


                    Navigator.push(context,
                     MaterialPageRoute(builder: (context) => AnimatedListSample()));
////                    ),
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
