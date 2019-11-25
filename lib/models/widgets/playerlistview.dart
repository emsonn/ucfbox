import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/game_data.dart';
import 'package:ucfbox/models/game_rooms/citronot_room.dart';
import 'package:ucfbox/models/players/citronot_player.dart';
//  Future<List<CitronotPlayer>> getPlayersInRoom(DatabaseReference gameRoom) async
//   {
//     List<CitronotPlayer> players = CitronotRoom.fromSnapshot(await gameRoom.once()).players;
//     return players;
//   }

class PlayerList extends StatefulWidget {
  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('\nWe are in the playerList View.');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}