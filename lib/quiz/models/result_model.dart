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
  String id;

  QuizResult({
    @required this.createdTime,
    @required this.result,
    @required this.username,
    @required this.userId,
    @required this.quizId,
    @required this.quizName,
    @required this.id,
  });

  static QuizResult fromJson(Map<String, dynamic> json) => QuizResult(
        createdTime: Utils.toDateTime(json['createdTime']),
        result: json['result'],
        username: json['username'],
        userId: json['userId'],
        quizId: json['quizId'],
        id: json['id'],
        quizName: json['quizName'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'result': result,
        'username': username,
        'userId': userId,
        'quizId': quizId,
        'id': id,
        'quizName': quizName,
      };
}
