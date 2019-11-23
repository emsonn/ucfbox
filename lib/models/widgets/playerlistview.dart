import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/game_data.dart';
import 'package:ucfbox/models/game_rooms/citronot_room.dart';
import 'package:ucfbox/models/players/citronot_player.dart';

class ListViewPlayer extends StatefulWidget {
//  @override
//  _ListViewPlayerState createState() => new _ListViewPlayerState()

  Widget build(BuildContext context) {
    return new Expanded(
      child:Container(
          child: ListView.builder()//ListView,
      ) ,
    );
  }

  Future<List<CitronotPlayer>> getPlayersInRoom(DatabaseReference gameRoom) async
  {
    List<CitronotPlayer> players = CitronotRoom.fromSnapshot(await gameRoom.once()).players;
    return players;
  }

  FutureBuilder fb(BuildContext context) {
    return new FutureBuilder(
      future: getPlayersInRoom(gameRoom), // async work
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('You are not connected!');

          case ConnectionState.waiting:
            return new Text('Loading....');

          default:
            return ListView.builder(
                itemBuilder: snapshot.data.length
            )
        }
      }
    );
  }
}
