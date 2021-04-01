import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final int questionNo;
  final String questionText;
  QuestionCard({@required this.questionNo, @required this.questionText});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Question ' + (questionNo + 1).toString(),
              style: TextStyle(
                  fontSize: 20,
                  // color: Color(0xFF6200E2),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              questionText,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
