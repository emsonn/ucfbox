import 'package:flutter/material.dart';

class RoleAssignment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
              child: Image.asset('images/studentIcon.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'You are Security',
              style:
                  TextStyle(fontFamily: 'Press Start 2P', color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
