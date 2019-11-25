import 'package:flutter/material.dart';
import 'package:ucfbox/games/knightquips/cards.dart';
import 'package:ucfbox/my_app_bar.dart';

class VotingRound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: Voting());
  }
}

class Voting extends StatelessWidget {
  String answer;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFFFC904),
      appBar: MyAppBar(),
//
//        )),
      body: SafeArea(
        child: Column(children: <Widget>[
          Text(
            'QUESTION:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Row(
                children: <Widget>[
                  SafeArea (

                    child: Container (child: AnswerCard(cardChild: Text('Hey my name is billy bob'),),)
                  ),

                  SafeArea (

                      child: Container (child: AnswerCard(cardChild: Text('Hey billy bob my name is jimmy job'),),)
                  ),
                  ]
                  ),
              ),

            ]
            ),
          ),
    );
  }
}
