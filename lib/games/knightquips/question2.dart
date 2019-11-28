import 'package:flutter/material.dart';
import 'package:ucfbox/games/knightquips/cards.dart';


class QAndAScreens extends StatefulWidget {
  static const String id = 'q_and_a';
  @override
  Question2 createState() => Question2();
}

class Question2 extends State<QAndAScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

//      appBar: MyAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /// Question
            Expanded(
              child: Container(

                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(
                  /// 140 character string
                  child: Text(
                    'THIS IS QUESTION 2',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFC904),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            /// Answer for Player A
            Expanded(
              child: AnswerCard(
                cardColor: Color(0xFFFFC904),
                onPress: () {
                  setState(() {
                    print('PLAYER A ANSWER');
                  });

//                  Navigator.pushNamed(context, RoundWinner.id);
                },
                cardChild: Center(
                  child: Text(
                    'Player A Answer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            /// Answer for Player B
            Expanded(
              child: AnswerCard(
                cardColor: Color(0xFFFFC904),
                onPress: () {
                  setState(() {
                    print('PLAYER B ANSWER');

//                    Navigator.pushReplacementNamed(context, RoundWinner.id);
                  });
                },
                cardChild: Center(
                  child: Text(
                    'Player B Answer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}