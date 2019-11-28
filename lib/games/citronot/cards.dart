import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  AnswerCard({this.answer, this.onPress, this.cardChild, this.cardColor});

  final String answer;
  final Color cardColor;
  final Function onPress;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}