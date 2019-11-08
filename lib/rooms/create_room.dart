// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:ucfbox/games/generate_code.dart';

import '../my_app_bar.dart';
import '../menu_of_games/game_card.dart';

class CreateRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// List that contains all the games JSON formats.
    List<GameCard> games = [
      /// Cirtronot
      GameCard(
        label: "CITRO\nNOT",
        color: Color(0xFFF10429),
        gameType: "citronot",
        gameRoomTemplate: {
          "gameType": "citronot",
          "players": [
            {
              "playerName": '',
              "score": 0,
              "start": false,
              "answer": "",
            }
          ],
          "voteCount": 0,
          "allTopics": [],
        },
      ),

      /// Quiplash
      GameCard(
        label: "QUIP\nLASH",
        color: Color(0xFF3DDA03),
        gameType: "quiplash",
        gameRoomTemplate: {
          "gameType": "quiplash",
          "players": [
            {
              "playerName": '',
              "score": 0,
              "start": false,
              "answer": "",
            }
          ],
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
          "gameType": "nightNightKnightro",
          "players": [
            {
              "playerName": '',
              "alive": false,
              "role": "",
              "votes": 0,
            }
          ],
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
