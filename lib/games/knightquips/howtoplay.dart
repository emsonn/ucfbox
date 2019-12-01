import 'package:ucfbox/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/internert_check/network_sensitive.dart';

class HowToPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Color(0xFFFFC904),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 55,
              ),
              Expanded(
                child: Text(
                  'HOW TO PLAY',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Text(
                  'Knight Quips is a competitive comedy\n '
                  'game in which the users are asked\n'
                  'to cleverly respond to a prompt\n'
                  'that is also given to another random player.\n\n'
                  'After inputting your answer, and all\n'
                  'players have answered their own prompts,\n'
                  'The prompts will one by one be displayed,\n'
                  'and all players but the ones who responded\n'
                  'to that given prompt, will vote on whichever\n'
                  ' answer they find the most humorous. \n\n'
                  ''
                  'If all players vote on your answer, then you have\n'
                  'achieved the max points for that round, and\n'
                  'the greatest accomplishment in this game: a KNIGHTQUIP!\n\n'
                  'The player with the greatest number of votes\n'
                  'wins!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
