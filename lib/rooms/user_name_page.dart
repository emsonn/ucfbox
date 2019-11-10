// import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/games/citronot.dart';
import 'package:ucfbox/games/night_night_knightro.dart';
import 'package:ucfbox/games/quiplash.dart';
import '../my_app_bar.dart';

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
  String playerNamePractice;
  @override
  void initState() {
    super.initState();
    print(
        '\n User Name Page\nThe gameRoomCode being pass is: ${widget.gameRoomCode}');
  }

  @override
  Widget build(BuildContext context) {
    /// Put one widget on top of another
    return Stack(
      children: <Widget>[
        Image.asset('images/classroom.png', fit: BoxFit.cover),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MyAppBar(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(50, 50, 50, 100),
              child: Card(
                color: Color(0xFFFFC904),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),

                  /// Organize things on a vertical orientation
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),

                        /// Player enter name
                        child: Text(
                          "ENTER\nYOUR\nUSER NAME",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),

                      /// Player enter the name
                      TextField(
                        onChanged: (text) {
                          /// This is bypasing the if statement and storing directly
                          /// into the json in the FlatButton widget.
                          /// Have to think of a way to code it where we don't use the
                          /// value of 1 for the player in location ONE
                          playerName = text;
                          if (FirebaseDatabase.instance
                                  .reference()
                                  .child(widget.gameRoomCode)
                                  .child('players')
                                  .child('2') ==
                              "") {
                            print('We are inside the if statement');
                            FirebaseDatabase.instance
                                .reference()
                                .child(widget.gameRoomCode)
                                .child('players')
                                .child('2')
                                .update({'playerName': text});

                            /// See if the playerName is in the if statement
                            print('After for loop POTATO\'S name: $text');
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.5),
                            ),
                            hintText: "1-12 characters"),
                      ),

                      ///  I added the Navigator.push()
                      FlatButton(
                        onPressed: () async {
                          print(
                              'FlatButton gameRoomCode is ${widget.gameRoomCode}');
                          print('FlatButton playerName is $playerName');

                          FirebaseDatabase.instance
                              .reference()
                              .child(widget.gameRoomCode)
                              .child('players')
                              .child('2')
                              .update({'playerName': playerName});

                          /// I'm going to try and take the name out of the database
                          /// by using a data snapShot like it's was done in join_room
                          /// then store that in a variable called playerNamePractice
                          /// to see if I did.

                          /// WORKS!!!!
                          /// CAN EXTRACT INFORMATION FROM THE DATABASE
                          FirebaseDatabase.instance
                              .reference()
                              .child(widget.gameRoomCode)
                              .child('players')
                              .child('2')
                              .child('playerName')
                              .once()
                              .then((DataSnapshot snapShot) {
                            playerNamePractice = snapShot.value
                                .toString(); //snapShot.value.toString();
                          }).toString();

                          /// Citronot
                          if (widget.gameType == "citronot") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Citronot(playerName: playerNamePractice),
                              ),
                            );
                          }

                          /// Knightquips
                          else if (widget.gameType == "quiplash") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Quiplash()));
                          }

                          /// NNN_Knightro
                          else if (widget.gameType == "nightNightKnightro") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NightNightKnightro()));
                          }

                          /// You suck
                          else {
                            print('you failed');
                          }
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
    );
  }
}
