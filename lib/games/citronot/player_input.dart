import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ucfbox/game_data.dart';
import 'package:ucfbox/games/citronot/voting_animatedlist.dart';
import 'package:ucfbox/models/players/citronot_player.dart';
import 'package:ucfbox/game_data.dart' as game_data;

class PlayerInput extends StatefulWidget {
  @override
  _PlayerInputState createState() => _PlayerInputState();
}

class _PlayerInputState extends State<PlayerInput> {
  @override
  Widget build(BuildContext context) {
    String userInput;
    return Container(
      color: Color(0xff654a07),

      /// Card
      child: Container(
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Enter Your Answer',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            /// Where the player enter there answer
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              maxLength: 140,
              inputFormatters: [LengthLimitingTextInputFormatter(140),],
              onChanged: (input) {
                print('$input');
                userInput = input;
              },
            ),
            SizedBox(height: 20),

            /// Submit Answer Button
            FlatButton(
              color: Colors.black,
              child: Text('Submit',
                  style: TextStyle(
                      color: Color(0xFFFFC904),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  )),
              onPressed: () async {
                print('The user input is the following: $userInput');

                var user = CitronotPlayer.fromSnapshot( await game_data.player.once() );
                user.answer = userInput;
                game_data.player.set(user.toJson());

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AnimatedListSample()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
