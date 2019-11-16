import 'package:flutter/material.dart';

class Voting extends StatefulWidget {
  @override
  _VotingState createState() => _VotingState();
}

class _VotingState extends State<Voting> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFC904),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  'This is a test to see how many characters should a player be able to see Also for when they input a answer to a question This is me adding x',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
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
