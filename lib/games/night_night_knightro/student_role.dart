import 'package:flutter/material.dart';

class StudentRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'You are a student,\n wait for the others',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontFamily: 'Press Start 2P'),
        ),
      ],
    );
  }
}
