import 'package:flutter/material.dart';

class LoseRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Text('Knightro Wins!',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontFamily: 'Press Start 2P')),
        ),
      ),
    );
  }
}
