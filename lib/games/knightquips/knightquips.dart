import 'package:flutter/material.dart';
import 'package:ucfbox/my_app_bar.dart';
import 'package:ucfbox/games/knightquips/howtoplay.dart';
import 'package:ucfbox/games/knightquips/question.dart';

void Quiplash() => runApp(KnightQuips());

class KnightQuips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: KnightQuipsHomeScreen());
  }
}

class KnightQuipsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFFFC904),
      appBar: MyAppBar(),
//
//        )),
      body: Center(
        child: Column(

          children: <Widget>[
            Expanded(
              flex: 3,
              child: Image.asset(
                'images/knightquips.png',
              ),
            ),

            Expanded(
              flex:3,
              child: Text(
                'PLAYERS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Expanded(
              flex: 0,
              child: RaisedButton(
                textColor: Color(0xFFFFC904),
                color: Colors.black,
                child: Text(
                  'How to Play',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HowToPlay()));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Expanded(
              flex: 0,
              child: RaisedButton(
                textColor: Color(0xFFFFC904),

                color: Colors.black,
                child: Text(
                  'Start Game',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  print('Start Game button has been pressed');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QAndAScreen()));
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}