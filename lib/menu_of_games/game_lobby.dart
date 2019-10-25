import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../games/citronot.dart';
import '../games/night_night_knightro.dart';
import '../games/quiplash.dart';
import '../my_app_bar.dart';
import 'game_card.dart';

class GameLobby extends StatelessWidget {
  GameLobby({this.playerName});
  final String playerName;

  @override
  Widget build(BuildContext context) {
    List<GameCard> games = [
      GameCard(
        label: "CITRO\nNOT",
        color: Color(0xFFF10429),
        route: Citronot(
          playerName: playerName,
        ),
      ),
      GameCard(
        label: "QUIP\nLASH",
        color: Color(0xFF3DDA03),
        route: Quiplash(
          playerName: playerName,
        ),
      ),
      GameCard(
        label: "NIGHT\nNIGHT\nKNIGHTRO",
        color: Color(0xFFBE038B),
        route: NightNightKnightro(
          playerName: playerName,
        ),
      ),
    ];

    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.black,
          appBar: MyAppBar(),
          body: SafeArea(
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
