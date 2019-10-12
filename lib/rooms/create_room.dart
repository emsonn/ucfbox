import 'package:flutter/material.dart';

import '../my_app_bar.dart';
import '../menu_of_games/game_lobby.dart';

class CreateRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                          "ENTER\nYOUR\nGAME CODE",
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
                            hintText: "Enter the 8 digit game code"),
                      ),
                      // TODO: I added the Navigator.push()
                      FlatButton(
                        onPressed: () {},
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

void createRoom() {}

void generateCode() {}
