import 'package:flutter/material.dart';

import 'my_app_bar.dart';
import 'rooms/join_room.dart';
import 'rooms/create_room.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFC904),
      appBar: MyAppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('images/knightro.png'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Center(
                    child: Text("UCFBox", style: TextStyle(fontSize: 60)),
                  ),
                ),
                SizedBox(),
                OutlineButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateRoom()));
                  },
                  borderSide: BorderSide(color: Colors.white, width: 2.5),
                  child: Text("CREATE ROOM",
                      style: TextStyle(color: Colors.white)),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JoinRoom()));
                  },
                  child:
                      Text("JOIN ROOM", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
