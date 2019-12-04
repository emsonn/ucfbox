import 'package:flutter/material.dart';

class WinRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Text('Knightro\'s been caught!',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontFamily: 'Press Start 2P')),
        ),
      ),
    );
  }
}
