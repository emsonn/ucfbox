import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:ucfbox/games/night_night_knightro/voting_room.dart';

class DiscussionTimer extends StatefulWidget {
  @override
  _DiscussionTimerState createState() => _DiscussionTimerState();
}

class _DiscussionTimerState extends State<DiscussionTimer> {
  DateTime alert;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    alert = DateTime.now().add(Duration(seconds: 5));
    return Container(
        child: TimerBuilder.scheduled([alert], builder: (context) {
      var now = DateTime.now();
      var reached = now.compareTo(alert) >= 0;
      return !reached
          ? TimerBuilder.periodic(
              Duration(seconds: 1),
              alignment: Duration.zero,
              builder: (context) {
                var now = DateTime.now();
                var remaining = alert.difference(now);
                return Text(
                  remaining.inSeconds.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Press Start 2P',
                      fontSize: 30),
                );
              },
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VotingRoom()));
                    },
                    child: Text('Done',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Press Start 2P',
                            fontSize: 30))),
                Image.asset(
                  'images/blinkingCursor.gif',
                  scale: .5,
                )
              ],
            );
    }));
  }
}
