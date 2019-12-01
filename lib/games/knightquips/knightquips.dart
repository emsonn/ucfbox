import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/games/knightquips/question.dart';
import 'package:ucfbox/models/game_rooms/knightquips_room.dart';
import 'package:ucfbox/models/players/knightquips_player.dart';
import 'package:ucfbox/games/knightquips/howtoplay.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/home_page.dart';
import 'package:ucfbox/internert_check/network_sensitive.dart';

class KnightQuips extends StatefulWidget {
  @override
  _KQState createState() => new _KQState();
}

class _KQState extends State<KnightQuips> {
  List<KnightQuipsPlayer> playerList = new List<KnightQuipsPlayer>();
  KnightQuipsPlayer player;
  DatabaseReference playerRef;

  var listen1;
  var listen2;
  var startListener;
  var beginSetup;
  var nextRoomListener;

  @override
  void initState() {
    super.initState();
    playerRef = game_data.gameRoom.child('players');
    listen1 = playerRef.onChildAdded.listen(_onPlayerAdded);
    listen2 = playerRef.onChildChanged.listen(_onPlayerChanged);
    startListener = game_data.gameRoom.onChildChanged.listen(_startGame);

    // Setup Gamewide Game leave room listern for host, DO NOT DISPOSE!!!
    // This should probably be set up elsewhere when we have time
    if (game_data.status == game_data.Status.host) {
      nextRoomListener =
          game_data.gameRoom.child('nextRoom').onValue.listen(_onNext);
      // Ready
      beginSetup = game_data.gameRoom
          .child('answerCount')
          .onValue
          .listen(_onCountChanged);
    }
  }

  _onNext(Event event) async {
    if ((await game_data.gameRoom.once()).value['noOfPlayers'] ==
        (await game_data.gameRoom.once()).value['nextRoom']) {
      game_data.gameRoom.child('nextRoom').set(0);
      game_data.gameRoom.child('answerCount').set(0);
    }
  }

  _startGame(Event event) async {
    if ((await game_data.gameRoom.once()).value['setup'] == true) {
      game_data.globalNumPlayers =
          (await game_data.gameRoom.once()).value['noOfPlayers'];

      final TransactionResult result = await game_data.gameRoom
          .child('nextRoom')
          .runTransaction((transaction) async {
        transaction.value = (transaction.value ?? 0) + 1;
        return transaction;
      });

      if (result.committed) {
        listen1.cancel();
        listen2.cancel();
        startListener.cancel();

        if (game_data.status == game_data.Status.host) beginSetup.cancel();

        // Set var back to false
        var myPlayer =
            KnightQuipsPlayer.fromSnapshot(await game_data.player.once());
        myPlayer.start = false;
        game_data.question1 = myPlayer.question1;
        game_data.question2 = myPlayer.question2;
        game_data.player.set(myPlayer.toJson());

        // start question1
        game_data.kQuipsRooms = game_data.KQuipsRooms.question1;

        // Continue
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => KQuipsQuestion()));
      }
    }
  }

  _onCountChanged(Event event) async {
    game_data.globalNumPlayers =
        (await game_data.gameRoom.once()).value['noOfPlayers'];

    if ((await game_data.gameRoom.once()).value['answerCount'] ==
            game_data.globalNumPlayers &&
        game_data.globalNumPlayers > 0) {
      // Get Questions from Firestore
      game_data.questionBank =
          await Firestore.instance.collection('knightquips').getDocuments();

      // Generate List of Topics
      List<int> allQuestions =
          new List<int>.generate((game_data.numKQuipsQuestions), (i) => i);
      allQuestions.shuffle();

      // Select Questions to use
      game_data.questionList = new List();
      for (int i = 0; i < game_data.globalNumPlayers; i++)
        game_data.questionList.add(allQuestions.removeLast());

      // Push Questions to the Database
      List<DatabaseReference> questionKeys = new List<DatabaseReference>();
      game_data.questionList.forEach((i) {
        questionKeys.add(game_data.gameRoom.child('questions').push());
        questionKeys.last.set({
          'prompt': game_data.questionBank.documents[game_data.topics]
              [i.toString()],
          'answers': []
        });
      });

      // Implementing sliding window in a terrible way
      var roomModel = KQuipsRoom.fromSnapshot(await game_data.gameRoom.once());

      // Assign first question
      var slidingWindowKeys = new List<DatabaseReference>();
      questionKeys.forEach((i) {
        slidingWindowKeys.add(i);
      });

      // Move last item to first for second question
      questionKeys.insert(0, questionKeys.removeLast());

      // Assign second question
      var index = 0;
      questionKeys.forEach((i) {
        slidingWindowKeys.insert(index, i);
        index += 2;
      });

      roomModel.players.forEach((key, value) async {
        var snap = await playerRef.child(key).once();

        playerRef
            .child(key)
            .child('q1')
            .set(slidingWindowKeys.removeLast().key);
        playerRef
            .child(key)
            .child('q2')
            .set(slidingWindowKeys.removeLast().key);
      });

      // Alert other users game is ready to begin
      game_data.gameRoom.child('setup').set(true);
      game_data.gameRoom.child('answerCount').set(0);
    }
  }

  _onPlayerAdded(Event event) {
    setState(() {
      playerList.add(KnightQuipsPlayer.fromSnapshot(event.snapshot));
    });
  }

  _onPlayerChanged(Event event) {
    var old = playerList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      playerList[playerList.indexOf(old)] =
          KnightQuipsPlayer.fromSnapshot(event.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: new Scaffold(
        backgroundColor: Color(0xFFFFC904),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  playerList.length--;

                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));

                  if (playerList.length == 0) {
                    game_data.gameRoom.remove();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                })
          ],
          leading: new Container(),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 9,
                child: Image.asset(
                  'images/knightquips.png',
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'Game Room Code:\n ${game_data.gameRoom.key}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'PLAYERS',
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
                          ));
                    }),
              ),
              Expanded(
                flex: 0,
                child: RaisedButton(
                  textColor: Color(0xFFFFC904),
                  color: Colors.black,
                  child: Text(
                    'How to Play',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    /// Change this back to How to Play!!!
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HowToPlay()));
                  },
                ),
              ),
              Expanded(
                flex: 0,
                child: RaisedButton(
                  textColor: Color(0xFFFFC904),
                  color: Colors.black,
                  child: Text(
                    'Start Game',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    // Update Player
                    var myPlayer = KnightQuipsPlayer.fromSnapshot(
                        await game_data.player.once());
                    myPlayer.start = true;
                    game_data.player.set(myPlayer.toJson());

                    // Update Users who have answered
                    await game_data.gameRoom
                        .child('answerCount')
                        .runTransaction((transaction) async {
                      transaction.value = (transaction.value ?? 0) + 1;
                      return transaction;
                    });
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
