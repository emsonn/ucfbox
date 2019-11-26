import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../my_app_bar.dart';
import '../menu_of_games/game_card.dart';

class CreateRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// List that contains all the games JSON formats.
    List<GameCard> games = [
      /// Citronot
      GameCard(
        label: "CITRO\nNOT",
        color: Color(0xFFF10429),
        gameType: "citronot",
        gameRoomTemplate: {
          "noOfPlayers": 0,
          "players:": [],
          "answers:": [],
          "gameType": "citronot",
          "prompt": "",
          "fact":"",
          "answerCount": 0
        },
      ),

      /// Quiplash
      GameCard(
        label: "KNIGHT\nQUIPS",
        color: Color(0xFF3DDA03),
        gameType: "quiplash",
        gameRoomTemplate: {
          "noOfPlayers": 0,
          "gameType": "quiplash",
          "players": [],
          "currentFact": "",
          "answerCount": 0,
        },
      ),

      /// NNN Knightro
      GameCard(
        label: "NIGHT\nNIGHT\nKNIGHTRO",
        color: Color(0xFFBE038B),
        gameType: "nightNightKnightro",
        gameRoomTemplate: {
          "noOfPlayers": 0,
          "gameType": "nightNightKnightro",
          "players": [],
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
