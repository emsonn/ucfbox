import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ucfbox/menu_of_games/game_lobby.dart';

import '../my_app_bar.dart';

class JoinRoom extends StatelessWidget {
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                      ],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.5),
                            ),
                            hintText: "Enter the 8 digit game code"),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GameLobby()));
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
