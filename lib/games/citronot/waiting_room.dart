import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/models/players/citronot_player.dart';
import 'package:ucfbox/my_app_bar.dart';

class WaitingRoom extends StatefulWidget {
  @override
  _WaitingState createState() => new _WaitingState();
}

class _WaitingState extends State<WaitingRoom> {
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
      /// Make a Results.Dart
//      Navigator.push(context,
//          MaterialPageRoute(builder: (context) => Results()));
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

      body: SafeArea(
        child: Column(
          children: <Widget>[

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
                            : Colors.white,
                        child: ListTile(
                          title: new Text(snapshot.value['playerName']),

                        ),
                    );
                  }
              ),
            ),

//            Expanded(
//              flex: 0,
//              child: RaisedButton(
//                textColor: Color(0xFFFFC904),
//                color: Colors.black,
//                child: Text(
//                  'Start Game',
//                  style: TextStyle(
//                    fontSize: 20,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//                onPressed: () async {
//                  print('Start Game button has been pressed');
//
//                  // Update Player
//                  var myPlayer = CitronotPlayer.fromSnapshot(
//                      await game_data.player.once());
//                  myPlayer.start = true;
//                  game_data.player.set(myPlayer.toJson());
//
//                  // Update Users who have answered
//                  var answered = (await game_data.gameRoom.once()).value['answerCount'];
//                  game_data.gameRoom.child('answerCount').set(answered + 1);
//                },
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
