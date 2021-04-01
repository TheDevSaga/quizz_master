import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz_master/model/question.dart';
import 'package:quizz_master/screens/result_screen.dart';
import 'package:quizz_master/screens/start_screen.dart';
import 'package:quizz_master/service/questions_api.dart';
import 'package:quizz_master/widget/question_card.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  Future<List<Question>> questionList;
  int questionNo = 0;
  List<Color> optionColorList;
  bool selected = false;
  int correctAnswer = 0;
  int sec = 30;
  void setColor() {
    optionColorList = [Colors.white, Colors.white, Colors.white, Colors.white];
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (sec < 1) {
          timer.cancel();
          nextQuestion();
        } else if (selected) {
          timer.cancel();
        } else {
          sec--;
        }
      });
    });
  }

  void nextQuestion() {
    print(correctAnswer.toString());
    if (questionNo < 4) {
      setState(() {
        sec = 30;
        startTimer();
        questionNo++;
        setColor();
        selected = false;
      });
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ResultScreen(
          correctAnswer: correctAnswer,
          totalQuestion: 5,
        );
      }));
    }
  }

  void checkAnswer({int correctAnswer, int selectedAnswer}) {
    selected = true;
    if (selectedAnswer == correctAnswer) {
      setState(() {
        this.correctAnswer++;
        optionColorList[selectedAnswer] = Colors.green;
      });
    } else {
      setState(() {
        optionColorList[correctAnswer] = Colors.green;
        optionColorList[selectedAnswer] = Colors.red;
      });
    }
    Timer(Duration(seconds: 2), nextQuestion);
  }

  @override
  void initState() {
    setColor();
    questionList = QuestionAPI().getQuestions();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    'Quit',
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    'Do you want to Quit quiz ???',
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StartScreen()));
                        },
                        child: Text('Quit')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'))
                  ],
                ));
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: FutureBuilder<List<Question>>(
              future: questionList,
              builder: (BuildContext bc, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sec.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF6200E2),
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Roman'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      QuestionCard(
                        questionNo: questionNo,
                        questionText: snapshot.data[questionNo].qText,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: Colors.black38)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                color: optionColorList[index],
                                onPressed: () {
                                  if (!selected) {
                                    checkAnswer(
                                        correctAnswer:
                                            snapshot.data[questionNo].ans,
                                        selectedAnswer: index);
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    snapshot.data[questionNo].options[index]
                                        .toString(),
                                    style: TextStyle(
                                        color: optionColorList[index] ==
                                                Colors.white
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
