import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
//import 'package:ucfbox/games/citronot/howtoplay.dart';
import 'package:ucfbox/games/knightquips/leaderboard.dart';
import 'package:ucfbox/games/knightquips/voting_animatedlist.dart';
import 'package:ucfbox/models/game_rooms/knightquips_room.dart';
import 'package:ucfbox/models/players/citronot_player.dart';
import 'package:ucfbox/my_app_bar.dart';
//import 'package:ucfbox/games/citronot/voting_animatedlist.dart';
//import 'package:ucfbox/games/citronot/results.dart';
//import 'package:ucfbox/games/citronot/question.dart';
//import 'package:ucfbox/models/answers/citronot_answer.dart';

class KQuipsWaitingRoom extends StatefulWidget {
  @override
  _KQuipsWaitingState createState() => new _KQuipsWaitingState();
}

class _KQuipsWaitingState extends State<KQuipsWaitingRoom> {
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
  }

  _onCountChanged(Event event) async{
    var val = (await game_data.gameRoom.once()).value['answerCount'];
    print('answerCount $val');
    if ((await game_data.gameRoom.once()).value['answerCount'] ==
        game_data.globalNumPlayers )
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

      if (game_data.kQuipsRooms == game_data.KQuipsRooms.voting) {
        // Generate who I need to vote for
        var roomModel = KQuipsRoom.fromSnapshot(await game_data.gameRoom.once());
        game_data.needToVoteFor = new List<String>();

        // Set Questions I need to vote for
        roomModel.questions.forEach((key, value) {
          if ( key != game_data.question1 && key != game_data.question2)
            game_data.needToVoteFor.add(key);
        });

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => KQuipsVoting()));
      }
      else if ( game_data.kQuipsRooms == game_data.KQuipsRooms.leaderboard) {
        Navigator.push(context, MaterialPageRoute( builder: (context) => KQuipsLeaderboard()));
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
                'images/knightquips.png',
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
