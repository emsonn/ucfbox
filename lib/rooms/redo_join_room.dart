// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:ucfbox/my_app_bar.dart';
// import 'package:ucfbox/rooms/user_name_page.dart';

// class JoinRoom extends StatefulWidget {
//   @override
//   _JoinRoomState createState() => _JoinRoomState();
// }

// class _JoinRoomState extends State<JoinRoom> {
//   String gameCode;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Image.asset(
//           'images/classroom.png',
//           fit: BoxFit.cover,
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           resizeToAvoidBottomInset: false,
//           appBar: MyAppBar(),
//           body: SafeArea(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(50, 50, 50, 100),
//               child: Card(
//                 color: Color(0xFFFFC904),
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),

//                   /// The UI objects are going to be layout in a vertical
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                         child: Text(
//                           'Enter\nYour\nGame Code',
//                           style: TextStyle(
//                             fontSize: 30.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),

//                       /// Player enter thire name
//                       TextField(
//                         autocorrect: false,
//                         textAlign: TextAlign.center,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(8),
//                           WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
//                         ],
//                         decoration: InputDecoration(
//                           hintText: 'Enter the 8 digit game code',
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.white,
//                               width: 2.5,
//                             ),
//                           ),
//                         ),
//                         onChanged: (value) {
//                           gameCode = value;
//                         },
//                       ),

//                       SizedBox(
//                         height: 24.0,
//                       ),

//                       FlatButton(
//                         color: Colors.black,
//                         child: Text(
//                           'Log IN',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onPressed: () async {
                          
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
