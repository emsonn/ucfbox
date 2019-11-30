import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/models/players/citronot_player.dart';
//import 'package:ucfbox/games/citronot/question.dart';
import 'package:ucfbox/games/citronot/leaderboard.dart';
//import 'package:firebase_database/ui/firebase_animated_list.dart';
class Results extends StatefulWidget {
  @override
  _ResultsState createState() => new _ResultsState();
}

class _ResultsState extends State<Results> {
  List<CitronotPlayer> playerList = new List<CitronotPlayer>();
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
    return new Scaffold(
      backgroundColor: Color(0xFFFFC904),

      body: Center(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(

                child: Text('RESULTS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                flex:2,
                child: Text('\n\nBased on your choice:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /// Need an if statement seeing if they chose correct answer or not

//              Expanded(
//                flex: 2,
//                child: Text(
//
//                  '\n\nBased on if players chose your lie:',
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                    fontSize: 25,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//              ),

              Expanded(
                flex: 0,
                child: RaisedButton(
                  textColor: Color(0xFFFFC904),
                  color: Colors.black,

                  /// IF STATEMENT SEEING IF THIS IS THE FINAL ROUND OR NOT
                  child: Text(
                    '\nCurrent Round Leaderboard\n',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Leaderboard()));
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}