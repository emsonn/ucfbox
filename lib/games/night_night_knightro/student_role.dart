import 'package:flutter/material.dart';

class StudentRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'You are a student,\nwait for the others',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontFamily: 'Press Start 2P'),
        ),
      ),
    );
  }
}
