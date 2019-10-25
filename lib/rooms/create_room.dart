import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../my_app_bar.dart';
import '../menu_of_games/game_card.dart';

class CreateRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<GameCard> games = [
      GameCard(
        label: "CITRO\nNOT",
        color: Color(0xFFF10429),
      ),
      GameCard(
        label: "QUIP\nLASH",
        color: Color(0xFF3DDA03),
      ),
      GameCard(
        label: "NIGHT\nNIGHT\nKNIGHTRO",
        color: Color(0xFFBE038B),
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
