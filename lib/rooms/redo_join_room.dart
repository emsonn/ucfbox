import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ucfbox/my_app_bar.dart';
import 'package:ucfbox/rooms/user_name_page.dart';

class JoinRoom extends StatefulWidget {
  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final dbReference = FirebaseDatabase.instance.reference();
  String gameCode;

  /// Checks to see if the room exist
  bool gameRoomExitst(String gameCode) {
    print('\nCode pass to gameRoomExists function: $gameCode');
    print(
        'The gameCode being pull out is: ${dbReference.}');
    return gameCode == dbReference.child(gameCode).once().toString();
  }

  /// Get the game type from the game room
  String getGameType(String gameCode) {
    print('\nSearching for game Type');
    return dbReference.child(gameCode).child('gameType').once().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'images/classroom.png',
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
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
                          'Enter\nYour\nGame Code',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      /// Player enter thire name
                      TextField(
                        autocorrect: false,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter the 8 digit game code',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.5,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          gameCode = value;
                        },
                      ),

                      SizedBox(
                        height: 24.0,
                      ),

                      FlatButton(
                        color: Colors.black,
                        child: Text(
                          'Log IN',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          try {
                            if (gameRoomExitst(gameCode)) {
                              print(
                                  '\nThe game type is: ${getGameType(gameCode)}');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserName(
                                      gameRoomCode: gameCode,
                                      gameType: getGameType(gameCode)),
                                ),
                              );
                            }

                            /// Display a alert that there was a problem
                            else {
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: 'UCFBox Alert',
                                desc:
                                    'The game room you entered does not exist!',
                                buttons: [
                                  DialogButton(
                                    width: 120,
                                    color: Color(0xFFFFC904),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'CHARGE ON!',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ).show();
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                      )
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
