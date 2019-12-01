import 'package:flutter/material.dart';
//import 'package:ucfbox/game_data.dart' as game_data;
//import 'package:ucfbox/games/citronot/citronot.dart';
//import 'package:ucfbox/games/knightquips/knightquips.dart';
//import 'package:ucfbox/games/night_night_knightro/night_night_knightro.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: <Widget>[

        IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            })
      ],

//      leading: new Container(),

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
