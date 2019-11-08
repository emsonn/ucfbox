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
  var playerName;

  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
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
                          // This is not printing either
                          print('POTATO name before the for loop is $text');
                          // ERROR on the if Statement
                          // wrong data types being compare
                          if (FirebaseDatabase.instance
                                  .reference()
                                  .child('gameRoomCode')
                                  .child('players')
                                  .child('0') ==
                              "") {
                            FirebaseDatabase.instance
                                .reference()
                                .child('gameRoomCode')
                                .child('players')
                                .child('0')
                                .update({'playerName': text});

                            /// The players name is not being store on the database
                            /// because this print stament never runs which means we
                            /// are never entering the for loop
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
                      //  I added the Navigator.push()
                      FlatButton(
                        onPressed: () {
                          /// Print statements for gameRoomCode and playerName
                          print('gameRoomCode is ${widget.gameRoomCode}');
                          print('Player name is ${widget.playerName}');

                          FirebaseDatabase.instance
                              .reference()
                              .child(widget.gameRoomCode)
                              .child('players')
                              .child('0')
                              .update({'playerName': widget.playerName});
                          if (widget.gameType == "citronot") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Citronot()));
                          } else if (widget.gameType == "quiplash") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Quiplash()));
                          } else if (widget.gameType == "nightNightKnightro") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NightNightKnightro()));
                          } else {
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
