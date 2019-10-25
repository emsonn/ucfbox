import 'dart:convert';

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
  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();

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
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.5),
                            ),
                            hintText: "1-12 characters"),
                        controller: myController,
                      ),
                      // TODO: I added the Navigator.push()
                      FlatButton(
                        onPressed: () {
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
