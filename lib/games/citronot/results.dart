import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/models/players/citronot_player.dart';
import 'package:ucfbox/my_app_bar.dart';
import 'package:ucfbox/games/citronot/question.dart';
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
    playerRef.onChildAdded.listen(_onPlayerAdded);
    playerRef.onChildChanged.listen(_onPlayerChanged);

    // Ready
    game_data.gameRoom.child('answerCount').onValue.listen(_onCountChanged);
  }

  _onCountChanged(Event event) async{
    if ((await game_data.gameRoom.once()).value['answerCount'] ==
        (await game_data.gameRoom.once()).value['noOfPlayers'])
    {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Question()));
    }
  }

  _onPlayerAdded(Event event) {
    setState(() {
      playerList.add(CitronotPlayer.fromSnapshot(event.snapshot));
      game_data.globalNumPlayers++;
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

      body: Center(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(

                child: Text('POINTS RESULTS:',
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


              Expanded(
                flex: 2,
                child: Text(

                  '\n\nBased on if players chose your lie:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),


              Expanded(
                flex: 4,
                child: Text(

                  '\n\n\nTotal Points:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                flex: 0,
                child: RaisedButton(
                  textColor: Color(0xFFFFC904),
                  color: Colors.black,

                  /// IF STATEMENT SEEING IF THIS IS THE FINAL ROUND OR NOT
                  child: Text(
                    'Current Round Leaderboard',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),


//                  child: Text(
//                    'Final Scores',
//                    style: TextStyle(
//                      fontSize: 20,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
                  onPressed: () async {
                    print('Start Game button has been pressed');

                    // Update Player
                    var myPlayer = CitronotPlayer.fromSnapshot(
                        await game_data.player.once());
                    myPlayer.start = true;
                    game_data.player.set(myPlayer.toJson());

                    // Update Users who have answered
                    var answered = (await game_data.gameRoom.once()).value['answerCount'];
                    game_data.gameRoom.child('answerCount').set(answered + 1);

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