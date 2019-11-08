import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:ucfbox/games/citronot.dart';
import 'package:ucfbox/games/night_night_knightro.dart';
import 'package:ucfbox/games/quiplash.dart';
import 'package:ucfbox/my_app_bar.dart';
import 'game_card.dart';


//TODO: Create the ROUTING SYSTEM to be able to move to game.
class GameLobby extends StatelessWidget {
  List<GameCard> games = [
    GameCard(
      label: "CITRO\nNOT",
      color: Color(0xFFF10429),
  //    route: Citronot(),
    ),
    GameCard(
      label: "QUIP\nLASH",
      color: Color(0xFF3DDA03),
   //   route: Quiplash(),
    ),
    GameCard(
      label: "NIGHT\nNIGHT\nKNIGHTRO",
      color: Color(0xFFBE038B),
   //   route: NightNightKnightro(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
