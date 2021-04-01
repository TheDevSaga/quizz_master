import 'package:flutter/material.dart';
import 'package:quizz_master/screens/questions_screen.dart';
import 'package:quizz_master/widget/buttons.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswer;
  final int totalQuestion;
  ResultScreen({@required this.correctAnswer, @required this.totalQuestion});
  @override
  Widget build(BuildContext context) {
    double result = correctAnswer / totalQuestion * 100;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Result',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50),
            ),
            Text(
              result.toStringAsFixed(1) + '%',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50,
                  color: result < 50.0 ? Colors.red : Colors.green),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Correct Answer',
              style: TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              correctAnswer.toString(),
              style: TextStyle(fontSize: 30, color: Colors.green),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Incorrect Answer',
              style: TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              (totalQuestion - correctAnswer).toString(),
              style: TextStyle(
                fontSize: 30,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            CircularButton(
              onClick: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return QuestionScreen();
                }));
              },
              icon: Icons.refresh,
            )
          ],
        ),
      ),
    );
  }
}
