import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/games/citronot/citronot.dart';
import 'package:ucfbox/games/night_night_knightro/night_night_knightro.dart';
import 'package:ucfbox/games/knightquips/knightquips.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../my_app_bar.dart';
import 'package:ucfbox/internert_check/network_sensitive.dart';

class UserName extends StatefulWidget {
  UserName({this.gameRoomCode, this.gameType});
  final gameRoomCode;
  final gameType;

  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  FirebaseDatabase dbReference = FirebaseDatabase.instance;
  String playerName;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: Stack(
        children: <Widget>[
          Image.asset('images/classroom.png', fit: BoxFit.cover),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: MyAppBar(),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(50, 50, 50, 100),
                child: Card(
                  color: Color(0xFFFFC904),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),

                    /// The UI objects are going to be layout in a vertical
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            "ENTER\nYOUR\nUSER NAME",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),

                        /// Box for entering message
                        TextField(
                          autocorrect: false,
                          onChanged: (text) {
                            playerName = text;
                          },

                          inputFormatters: [
                            LengthLimitingTextInputFormatter(12),
                            WhitelistingTextInputFormatter(
                                RegExp("[a-zA-Z0-9]")),
                          ],

                          /// Decoration for text box
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.5),
                              ),
                              hintText: "Enter in a 12 character player name"),

                          /// Input playerName is empty.
                          onSubmitted: (gameCode) async {
                            if (playerName.length == 0) {
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: "UCFBox Alert",
                                desc:
                                    "Please enter in 1-12 characters for your username.",
                                buttons: [
                                  DialogButton(
                                    color: Color.fromRGBO(225, 202, 6, 100),
                                    child: Text(
                                      "CHARGE ON!",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            }

                            /// Input playerName is valid
                            else {
                              

                              game_data.player = FirebaseDatabase.instance
                                  .reference()
                                  .child(widget.gameRoomCode)
                                  .child('players')
                                  .push();

                              DatabaseReference noOfPlayers = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child(widget.gameRoomCode)
                                  .child('noOfPlayers');

                              game_data.gameRoom = FirebaseDatabase.instance
                                  .reference()
                                  .child(widget.gameRoomCode);

                              noOfPlayers.once().then((DataSnapshot snapshot) {
                                noOfPlayers.set(snapshot.value + 1);
                              });

                              /// Citronot
                              if (widget.gameType == "citronot") {
                                game_data.player.set({
                                  'playerName': playerName,
                                  'score': 0,
                                  'answer': '',
                                  'start': false,
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Citronot(),
                                  ),
                                );
                              }

                              /// Knightquips
                              else if (widget.gameType == "knightQuips") {
                                
//                              String test = "testThis";
                                game_data.player.set({
                                  'playerName': playerName,
                                  'q1': "",
                                  'q2': "",
                                  'score': 0,
                                  'start': false,
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => KnightQuips()));
                              }

                              /// NNN_Knightro
                              else if (widget.gameType ==
                                  "nightNightKnightro") {
                                game_data.player.set({
                                  'playerName': playerName,
                                  'alive': true,
                                  'role': '',
                                  'votes': 0,
                                  'start': false
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NightNightKnightro()));
                              }

                              /// Failure condition
                              else {
                                print('failure');
                              }
                            }
                          },
                        ),

                        FlatButton(
                          onPressed: () async {
                            if (playerName.length == 0) {
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: "UCFBox Alert",
                                desc:
                                    "Please enter in 1-12 characters for your username.",
                                buttons: [
                                  DialogButton(
                                    color: Color.fromRGBO(225, 202, 6, 100),
                                    child: Text(
                                      "CHARGE ON!",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            } else {
                              

                              game_data.player = FirebaseDatabase.instance
                                  .reference()
                                  .child(widget.gameRoomCode)
                                  .child('players')
                                  .push();

                              DatabaseReference noOfPlayers = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child(widget.gameRoomCode)
                                  .child('noOfPlayers');

                              game_data.gameRoom = FirebaseDatabase.instance
                                  .reference()
                                  .child(widget.gameRoomCode);

                              noOfPlayers.once().then((DataSnapshot snapshot) {
                                noOfPlayers.set(snapshot.value + 1);
                              });

                              /// Citronot
                              if (widget.gameType == "citronot") {
                                game_data.player.set({
                                  'playerName': playerName,
                                  'score': 0,
                                  'answer': '',
                                  'start': false
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Citronot(),
                                  ),
                                );
                              }

                              /// Knightquips
                              else if (widget.gameType == "knightQuips") {
                                game_data.player.set({
                                  'playerName': playerName,
                                  'score': 0,
                                  'start': false
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => KnightQuips()));
                              }

                              /// NNN_Knightro
                              else if (widget.gameType ==
                                  "nightNightKnightro") {
                                game_data.player.set({
                                  'playerName': playerName,
                                  'alive': true,
                                  'role': '',
                                  'votes': 0,
                                  'start': false
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NightNightKnightro()));
                              } else {
                                print('you failed');
                              }
                            } // on pressed ends
                          },
                          color: Colors.black,
                          child: Text(
                            "CHARGE ON!",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
