import 'package:flutter/material.dart';

import '../my_app_bar.dart';

class CreateRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(),
      body: SafeArea(
        child: Center(
          child: Text(
            "CREATE GAME",
            style: TextStyle(fontSize: 60, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
