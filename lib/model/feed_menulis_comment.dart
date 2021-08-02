import 'package:flutter/cupertino.dart';
import 'package:rusa4/Utils/utils.dart';

class FeedMenulisCommentField {
  static const createdTime = 'createdTime';
}

class FeedMenulisComment {
  DateTime createdTime;
  String id;
  String description;
  String writer;
  String userId;

  FeedMenulisComment({
    @required this.createdTime,
    @required this.description,
    @required this.id,
    @required this.writer,
    @required this.userId,
  });

  static FeedMenulisComment fromJson(Map<String, dynamic> json) =>
      FeedMenulisComment(
        createdTime: Utils.toDateTime(json['createdTime']),
        description: json['description'],
        id: json['id'],
        writer: json['writer'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'description': description,
        'id': id,
        'writer': writer,
        'userId': userId,
      };
}
