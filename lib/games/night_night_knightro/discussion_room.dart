import 'package:flutter/material.dart';
import 'package:ucfbox/games/night_night_knightro/discussion_timer.dart';
import 'package:ucfbox/games/night_night_knightro/role_assignment.dart';

class DiscussionRoom extends StatefulWidget {
  @override
  _DiscussionRoomState createState() => _DiscussionRoomState();
}

class _DiscussionRoomState extends State<DiscussionRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            RoleAssignment(),
            SizedBox(
              height: 30,
            ),
            DiscussionTimer(),
          ],
        ),
      ),
    );
  }
}
