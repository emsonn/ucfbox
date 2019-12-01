import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ucfbox/my_app_bar.dart';
import 'game_card.dart';

//Create the ROUTING SYSTEM to be able to move to game.
class GameLobby extends StatelessWidget {
  List<GameCard> games = [
    GameCard(
      label: "CITRO\nNOT",
      color: Color(0xFFFFA726),
    ),
    GameCard(
      label: "KNIGHT\nQUIPS",
      color: Color(0xFFF48FB1),
    ),
    GameCard(
      label: "NIGHT\nNIGHT\nKNIGHTRO",
      color: Color(0xFFBA68C8),
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
