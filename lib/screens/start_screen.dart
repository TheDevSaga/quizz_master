import 'package:flutter/material.dart';
import 'package:quizz_master/screens/questions_screen.dart';
import 'package:quizz_master/widget/buttons.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircularButton(
              onClick: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return QuestionScreen();
                }));
              },
              icon: Icons.play_arrow,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Start Quiz',
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }
}
