import 'package:flutter/material.dart';
import 'package:ucfbox/my_app_bar.dart';
import 'package:ucfbox/games/citronot/player_input.dart';
import 'package:ucfbox/games/citronot/voting.dart';

class Question extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// App bar
      appBar: MyAppBar(),

      /// BUTTON WHERE THE USER CAN ENTER THE QUESTION.
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.question_answer, color: Color(0xff654a07)),
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => PlayerInput());
        },
      ),

      /// Container
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 30),

              /// Question is displayed
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFC904),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    /// 140 Character
                    child: Text(
                      'This is a test to see how many characters should a player be able to see Also for when they input a answer to a question This is me adding x',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              /// Start Button
              Expanded(
                child: RaisedButton(
                  color: Color(0xFFFFC904),
                  child: Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                          Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Voting()));
                  },
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
