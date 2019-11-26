import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/games/generate_code.dart';
import '../rooms/user_name_page.dart';
import 'package:ucfbox/game_data.dart' as game_data;

class GameCard extends StatelessWidget {
  GameCard({this.label, this.color, this.gameRoomTemplate, this.gameType});
  final label;
  final color;
  final gameRoomTemplate;
  final gameType;

  final gameRoomCode = generateCode();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(50, 50, 50, 100),
        child: InkWell(
          onTap: () {
            pushToDB(gameRoomCode, gameRoomTemplate);
            game_data.status = game_data.Status.host;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserName(
                          gameRoomCode: gameRoomCode,
                          gameType: gameType,
                        )));
          },
          child: Card(
            color: color,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void pushToDB(roomCode, gameRoomInstance) {
  FirebaseDatabase.instance.reference().child(roomCode).set(gameRoomInstance);
}
