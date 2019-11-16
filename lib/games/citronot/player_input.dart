import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              child: Text('Submite',
                  style: TextStyle(
                      color: Color(0xFFFFC904),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                print('The user input is the following: $userInput');
              },
            ),
          ],
        ),
      ),
    );
  }
}
