import 'package:flutter/material.dart';
import 'package:ucfbox/my_app_bar.dart';
import 'package:ucfbox/games/citronot/howtoplay.dart';
import 'package:ucfbox/games/citronot/question.dart';

class Citronot extends StatefulWidget {
  @override
  _CitronotState createState() => _CitronotState();
}

class _CitronotState extends State<Citronot> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFFFC904),
      appBar: MyAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            /// Logo
            Expanded(
              flex: 5,
              child: Image.asset(
                'images/citronot.png',
              ),
            ),

            /// List of players
            Expanded(
              flex: 3,
              child: Text(
                'PLAYERS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),

            /// How to play button
            Expanded(
              flex: 0,
              child: RaisedButton(
                textColor: Color(0xFFFFC904),
                color: Colors.black,
                child: Text(
                  'How to Play',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HowToPlay()));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),

            /// Start Game Button
            Expanded(
              flex: 0,
              child: RaisedButton(
                textColor: Color(0xFFFFC904),
                color: Colors.black,
                child: Text(
                  'Start Game',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                   Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Question()));
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

// class Citronot extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(home: CitronotHomeScreen());
//   }
// }

// class CitronotHomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       backgroundColor: Color(0xFFFFC904),
//       appBar: MyAppBar(),

//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               flex: 0,
//               child: Image.asset(
//                 'images/citronot.png',
//               ),
//             ),

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
//                   print('Start Game button has been pressed');
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
