class Question {
  String qText;
  List<dynamic> options;
  int ans;
  Question({this.qText, this.options, this.ans});

  Question.fromMap(Map<String, dynamic> map)
      : qText = map['qText'],
        options = map['options'],
        ans = map['ans'];
}
