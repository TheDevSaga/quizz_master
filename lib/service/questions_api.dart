import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizz_master/model/question.dart';

class QuestionAPI {
  final _firestoreInstance = FirebaseFirestore.instance;

  Future<List<Question>> getQuestions() async {
    List<Question> questionsList = [];
    await _firestoreInstance
        .collection("questions")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        final Map<String, dynamic> map = result.data();
        questionsList.add(Question.fromMap(map));
      });
    });
    return questionsList;
  }
}
