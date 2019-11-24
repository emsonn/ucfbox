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
    onChangedSubscription = game_data.gameRoom.onChildChanged.listen(onChanged); 
    
    // CitronotPlayer player1 = CitronotPlayer('qwery', 2, false, 'Do Work');
    // CitronotPlayer player2 = CitronotPlayer('helo', 3, true, 'Do run');

    // list.add(player1);
    // list.add(player2);
    // print(list[0].playerName);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<CitronotRoom>(
        stream: ,)
        ,)
//     return Center(
//       child: StreamBuilder(
// stream: game_data.gameRoom.child('players')

//               child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: list.players.length,
//           padding: const EdgeInsets.all(15.0),
//           itemBuilder: (context, position) {
//             return new Text('${list.players[position]}');
//           },
//         ),
//       ),
//     );
//   }
}
// class Citronot extends StatefulWidget {
//   @override
//   _CitronotState createState() => _CitronotState();
// }

// class _CitronotState extends State<Citronot> {
//   @override
//   void initState() {
//     super.initState();
//     print('\nWe are in the citronot initstate');
//     PlayerList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       backgroundColor: Color(0xFFFFC904),
//       appBar: MyAppBar(),
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             /// Logo
//             Expanded(
//               flex: 5,
//               child: Image.asset(
//                 'images/citronot.png',
//               ),
//             ),

//             /// List of players
//             Expanded(
//               flex: 3,
//               child: Text(
//                 'PLAYERS',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 60,
//             ),

//             /// How to play button
//             Expanded(
//               flex: 0,
//               child: RaisedButton(
//                 textColor: Color(0xFFFFC904),
//                 color: Colors.black,
//                 child: Text(
//                   'How to Play',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => HowToPlay()));
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),

//             /// Start Game Button
//             Expanded(
//               flex: 0,
//               child: RaisedButton(
//                 textColor: Color(0xFFFFC904),
//                 color: Colors.black,
//                 child: Text(
//                   'Start Game',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Question()));
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class Citronot extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return new MaterialApp(home: CitronotHomeScreen());
// //   }
// // }

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
