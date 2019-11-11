import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:ucfbox/my_app_bar.dart';
import 'package:ucfbox/games/night_night_knightro/howtoplay.dart';

void NNKGame() => runApp(NightNightKnightro());

class NightNightKnightro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: NightNightKnightroHomeScreen());
  }
}

class NightNightKnightroHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFFFC904),
      appBar: MyAppBar(),
//
//        )),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Image.asset(
                'images/nightnightknightro.png',
              ),
            ),
//              SizedBox(
//                height: 20,
//              ),
            Expanded(
              flex: 3,
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
