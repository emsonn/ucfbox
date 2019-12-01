import 'dart:ui' as prefix0;

import 'package:ucfbox/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/internert_check/network_sensitive.dart';
class HowToPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
          child: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Color(0xFFFFC904),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
              ),
              Expanded(
                flex: 0,
                child: Text(
                  '      HOW TO PLAY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '\n'
                      '     Citronot is a UCF trivia party\n'
                      '     game where you try to trick\n'
                      '      your opponents with your own\n '
                      '    lie, and try to pick out the\n '
                      '    truth out of a pool of\n '
                      '    possible wrong answers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
