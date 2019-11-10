// import 'dart:core' as prefix0;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ucfbox/rooms/user_name_page.dart';

import '../my_app_bar.dart';

// class JoinRoom extends StatefulWidget {
//   @override
//   _JoinRoomState createState() => _JoinRoomState();
// }

// class _JoinRoomState extends State<JoinRoom> {
//   String gameCode;
//     /// Checks to see if the room exits
//   Future<bool> gameRoomExists(String gameCode) async {
//     //database reference.
//     print('code pass to gameRoomExists function: $gameCode');
//     return FirebaseDatabase.instance
//         .reference()
//         .child(gameCode)
//         .once()
//         .then((DataSnapshot data) {
//       print('\ngameRoomExists: ${data.key.isNotEmpty && data.value != null}\n');
//       return data.key.isNotEmpty && data.value != null;
//     });
//   }

//   /// Return the game type that was choosen
//   Future<String> getGameType(String gameCode) async {
//     //database reference.
//     print('code pass to getGameType function: $gameCode');
//     return FirebaseDatabase.instance
//         .reference()
//         .child(gameCode)
//         .child('gameType')
//         .once()
//         .then((DataSnapshot data) {
//       print('\ngetGameType data.value: ${data.value}\n');
//       return data.value;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     print('\nJoin Room Page\n');
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Image.asset('images/classroom.png', fit: BoxFit.cover),
//         Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.transparent,
//           appBar: MyAppBar(),
//           body: SafeArea(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(50, 50, 50, 100),
//               child: Card(
//                 color: Color(0xFFFFC904),
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),

//                   /// The UI objects are going to be layout in a vertical
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 0, 0, 10),

//                         ////// Game Code Message
//                         child: Text(
//                           "ENTER\nYOUR\nGAME CODE",
//                           style: TextStyle(
//                               fontSize: 30, fontWeight: FontWeight.bold),
//                         ),
//                       ),

//                       /// Box for entering message
//                       TextField(
//                         autocorrect: false,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(8),
//                           WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
//                         ],

//                         /// Decoration for text box
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(color: Colors.white, width: 2.5),
//                             ),
//                             hintText: "Enter the 8 digit game code"),

//                         /// Async function
//                         /// gameCode is enter by user
//                         onSubmitted: (gameCode) async {
//                           ///
//                           /// If the gameCode matches with a existing room, then push player
//                           /// into the room with the gameCode and gameRoomType.
//                           if (await gameRoomExists(gameCode)) {
//                             // create user name and update the gameroom.
//                             getGameType(gameCode).then(
//                               (gameRoomType) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => UserName(
//                                       gameRoomCode: gameCode,
//                                       gameType: gameRoomType,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           }

//                           /// If the room does not exist
//                           else {
//                             Alert(
//                               context: context,
//                               type: AlertType.error,
//                               title: "UCFBox Alert",
//                               desc: "The game room you entered does not exist!",
//                               buttons: [
//                                 DialogButton(
//                                   color: Color.fromRGBO(225, 202, 6, 100),
//                                   child: Text(
//                                     "CHARGE ON!",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 20),
//                                   ),
//                                   onPressed: () => Navigator.pop(context),
//                                   width: 120,
//                                 )
//                               ],
//                             ).show();
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class JoinRoom extends StatelessWidget {
  String gameCode;

  /// Checks to see if the room exits
  Future<bool> gameRoomExists(String gameCode) async {
    //database reference.
    print('code pass to gameRoomExists function: $gameCode');
    return FirebaseDatabase.instance
        .reference()
        .child(gameCode)
        .once()
        .then((DataSnapshot data) {
      print('gameRoomExists: ${data.key.isNotEmpty && data.value != null}\n');
      return data.key.isNotEmpty && data.value != null;
    });
  }

  /// Return the game type that was choosen
  Future<String> getGameType(String gameCode) async {
    //database reference.
    print('code pass to getGameType function: $gameCode');
    return FirebaseDatabase.instance
        .reference()
        .child(gameCode)
        .child('gameType')
        .once()
        .then((DataSnapshot data) {
      print('getGameType data: ${data.value}\n');
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

                  /// The UI objects are going to be layout in a vertical
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),

                        ////// Game Code Message
                        child: Text(
                          "ENTER\nYOUR\nGAME CODE",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),

                      /// Box for entering message
                      TextField(
                        autocorrect: false,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                        ],

                        /// Decoration for text box
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.5),
                            ),
                            hintText: "Enter the 8 digit game code"),

                        /// gameCode is enter by user
                        onSubmitted: (gameCode) async {
                          if (await gameRoomExists(gameCode)) {
                            getGameType(gameCode).then(
                              (gameRoomType) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserName(
                                      gameRoomCode: gameCode,
                                      gameType: gameRoomType,
                                    ),
                                  ),
                                );
                              },
                            );
                          }

                          /// If the room does not exist
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
                        },
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
