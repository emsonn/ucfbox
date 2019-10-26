import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ucfbox/rooms/user_name_page.dart';

import '../my_app_bar.dart';

class JoinRoom extends StatelessWidget {

  Future<bool> gameRoomExists(String gameCode) async {

    //database reference.
    return FirebaseDatabase.instance.reference().child(gameCode).once().then((DataSnapshot data)
    {
      return data.key.isNotEmpty && data.value != null;
    });
  }

  Future<String> getGameType(String gameCode) async {

    //database reference.
    return FirebaseDatabase.instance.reference().child(gameCode).child('gameType').once().then((DataSnapshot data)
    {
      return data.value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
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
                        autocorrect: false,
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
                            onSubmitted: (gameCode) async {
                              if ( await gameRoomExists(gameCode) ) {
                                // TODO: create user name and update the gameroom.
                                  getGameType( gameCode ).then( (gameRoomType) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UserName(
                                                  gameRoomCode: gameCode,
                                                  gameType: gameRoomType,
                                                )));
                                  });
                              }
                              else {
                                Alert(
                                  context: context,
                                  type: AlertType.error,
                                  title: "UCFBox Alert",
                                  desc: "The game room you entered does not exist!",
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
                              }),
//                          },
//                      ),
//                      FlatButton(
//                        onPressed: () {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => GameLobby()));
//
//                      ),
//                      // TODO: I added the Navigator.push()
//                      FlatButton(
//                        onPressed: () {
//
//                          }
//                        },
//                        color: Colors.black,
//                        child: Text(
//                          "CHARGE ON!",
//                          style: TextStyle(color: Colors.white),
//                        ),
//                      ),
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
