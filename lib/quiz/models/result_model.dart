import 'package:flutter/cupertino.dart';
import 'package:rusa4/Utils/utils.dart';

class QuizResultField {
  static const createdTime = 'createdTime';
}

class QuizResult {
  DateTime createdTime;
  String username;
  double result;
  String userId;
  String quizId;
  String quizName;
  String id, quizGuru;
  List cekJawaban;
  List optionSelected;
  List correctAnswer;
  int correct;
  int incorrect;
  int total;
  String description;

  QuizResult({
    @required this.createdTime,
    @required this.result,
    @required this.username,
    @required this.userId,
    @required this.quizId,
    @required this.quizName,
    @required this.id,
    @required this.quizGuru,
    @required this.cekJawaban,
    @required this.optionSelected,
    @required this.correctAnswer,
    @required this.correct,
    @required this.incorrect,
    @required this.total,
    @required this.description,
  });

  static QuizResult fromJson(Map<String, dynamic> json) => QuizResult(
        createdTime: Utils.toDateTime(json['createdTime']),
        result: json['result'].toDouble(),
        username: json['username'],
        userId: json['userId'],
        quizId: json['quizId'],
        id: json['id'],
        quizName: json['quizName'],
        cekJawaban: json['cekJawaban'],
        optionSelected: json['optionSelected'],
        correctAnswer: json['correctAnswer'],
        correct: json['correct'],
        incorrect: json['incorrect'],
        total: json['total'],
        description: json['description'],
        quizGuru: json['quizGuru'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'result': result,
        'username': username,
        'userId': userId,
        'quizId': quizId,
        'id': id,
        'quizName': quizName,
        "cekJawaban": cekJawaban,
        "optionSelected": optionSelected,
        "correctAnswer": correctAnswer,
        "correct": correct,
        "incorrect": incorrect,
        "total": total,
        "description": description,
        "quizGuru": quizGuru,
      };
}
