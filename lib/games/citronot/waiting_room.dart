import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/games/citronot/howtoplay.dart';
import 'package:ucfbox/models/players/citronot_player.dart';
import 'package:ucfbox/my_app_bar.dart';
import 'package:ucfbox/games/citronot/voting_animatedlist.dart';

class WaitingRoom extends StatefulWidget {
  @override
  _WaitingState createState() => new _WaitingState();
}

class _WaitingState extends State<WaitingRoom> {
  List<CitronotPlayer> playerList = new List<CitronotPlayer>();
  CitronotPlayer player;
  DatabaseReference playerRef;
  var listen1;
  var listen2;

  @override
  void initState() {
    super.initState();
    player = new CitronotPlayer("", 0, false, "");
    playerRef = game_data.gameRoom.child('players');
//    playerRef.onChildAdded.listen(_onPlayerAdded);
    listen1 = playerRef.onChildChanged.listen(_onPlayerChanged);

    // Ready
    listen2 = game_data.gameRoom.child('answerCount').onValue.listen(_onCountChanged);
  }

  @override
  void dispose() {
    super.dispose();
    listen1.cancel();
    listen2.cancel();
  }

  _onCountChanged(Event event) async{
    if ((await game_data.gameRoom.once()).value['answerCount'] ==
        (await game_data.gameRoom.once()).value['noOfPlayers'])
    {
      /// Make a Results.Dart
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AnimatedListSample()));
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
