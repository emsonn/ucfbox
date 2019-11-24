import 'dart:async';

import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ucfbox/game_data.dart' as game_data;
import 'package:ucfbox/models/game_rooms/citronot_room.dart';
import 'package:ucfbox/models/players/citronot_player.dart';
// import 'package:ucfbox/my_app_bar.dart';
// import 'package:ucfbox/games/citronot/howtoplay.dart';
// import 'package:ucfbox/games/citronot/question.dart';
// import 'package:ucfbox/models/widgets/playerlistview.dart';

class Citronot extends StatefulWidget {
  @override
  _CitronotState createState() => new _CitronotState();
}

class _CitronotState extends State<Citronot> {
  CitronotRoom list;

  StreamSubscription<Event> onChangedSubscription;

  void getPlayerList() async {
   var work = (await game_data.gameRoom.once()).toString();
   print(work);
    list = CitronotRoom.fromSnapshot(await game_data.gameRoom.once());
  }

  @override
  void initState() {
    super.initState();
    getPlayerList();
    
    // CitronotPlayer player1 = CitronotPlayer('qwery', 2, false, 'Do Work');
    // CitronotPlayer player2 = CitronotPlayer('helo', 3, true, 'Do run');

    // list.add(player1);
    // list.add(player2);
    // print(list[0].playerName);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder(
          stream: game_data.gameRoom.onChildChanged,
          builder: (context, snapshot) {
            if ( snapshot.connectionState == ConnectionState.done)
              {
                var room = CitronotRoom.fromSnapshot(snapshot.data);
                return Text('${room.players[0]}');
              }
            else if ( snapshot.connectionState == ConnectionState.waiting)
              {
                return Text("Loading...");
              }
            else if ( snapshot.hasError)
              {
                return Text("Error!");
              }
          },
        )
    );
  }

  Widget citronotListView(CitronotRoom room)
  {
    return ListView.builder(
        itemCount: room.players.length,
        itemBuilder: (context, position){
          return new Text('${room.players[position]}');
        }
        
    );
  }


}

// // class CitronotHomeScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return new Scaffold(
// //       backgroundColor: Color(0xFFFFC904),
// //       appBar: MyAppBar(),

// //       body: SafeArea(
// //         child: Column(
// //           children: <Widget>[
// //             Expanded(
// //               flex: 0,
// //               child: Image.asset(
// //                 'images/citronot.png',
// //               ),
// //             ),

// //             Expanded(
// //               flex: 3,
// //               child: Text(
// //                 'PLAYERS',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontSize: 25,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               height: 60,
// //             ),
// //             Expanded(
// //               flex: 0,
// //               child: RaisedButton(
// //                 textColor: Color(0xFFFFC904),
// //                 color: Colors.black,
// //                 child: Text(
// //                   'How to Play',
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 onPressed: () {
// //                   Navigator.push(context,
// //                       MaterialPageRoute(builder: (context) => HowToPlay()));
// //                 },
// //               ),
// //             ),
// //             SizedBox(
// //               height: 10,
// //             ),

// //             Expanded(
// //               flex: 0,
// //               child: RaisedButton(
// //                 textColor: Color(0xFFFFC904),
// //                 color: Colors.black,
// //                 child: Text(
// //                   'Start Game',
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 onPressed: () {
// //                   print('Start Game button has been pressed');
// //                 },
// //               ),
// //             ),
// //             SizedBox(
// //               height: 30,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
