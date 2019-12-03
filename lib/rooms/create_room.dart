import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../my_app_bar.dart';
import '../menu_of_games/game_card.dart';
import 'package:connectivity/connectivity.dart';
class CreateRoom extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {

   _showDialog(context, title, text) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
      );
    }

    _checkInternetConnection() async {
      var result = await Connectivity().checkConnectivity();
      print('You are in _checkInternetConnection');
      print('Result ==> $result');
      if (result == ConnectivityResult.none) {
      _showDialog(context, 'hello', 'welcome');
      }
    }

 
    /// List that contains all the games JSON formats.
    List<GameCard> games = [
      /// Citronot
      GameCard(
        label: "CITRO\nNOT",
        color: Color(0xFFFFA726),
        image: 'images/citro.png',
        gameType: "citronot",
        gameRoomTemplate: {
          "noOfPlayers": 0,
          "players:": [],
          "answers:": [],
          "gameType": "citronot",
          "prompt": "",
          "fact": "",
          "nextRoom": 0,
          "answerCount": 0
        },
      ),

      /// KnightQuips
      GameCard(
        label: "KNIGHT\nQUIPS",
        color: Color(0xFF757575),
        image: 'images/kq.png',
        gameType: "knightQuips",
        gameRoomTemplate: {
          "gameType": "knightQuips",
          "setup": false,
          "noOfPlayers": 0,
          "nextRoom": 0,
          "answerCount": 0,
          "players":[],
          "questions":[]
        },
      ),

      /// NNN Knightro
      GameCard(
        label: "NIGHT\nNIGHT\nKNIGHTRO",
        color: Color(0xFF1565C0),
        image: 'images/nightnightknightro.png',
        gameType: "nightNightKnightro",
        gameRoomTemplate: {
          "noOfPlayers": 0,
          "gameType": "nightNightKnightro",
          "players": [],
          "randomRoles": ["knightro", "security", "student", "professor"],
          "alivePlayersCount": 0,
          "voteCount": 0,
          "killed": "",
          "isDaytime": false,
        },
      ),
    ];

    /// Stack puts one card ontop of another
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.black,
          appBar: MyAppBar(),
          body: SafeArea(
            /// Swiper gives the cards a horizontal movement
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                _checkInternetConnection();
                print('\n\n${games[index].toStringDeep()}\n\n');
                return games[index];
              },
              itemCount: 3,
            ),
          ),
        ),
      ],
    );
  }
}
