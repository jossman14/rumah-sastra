import 'package:flutter/cupertino.dart';
import 'package:rusa4/Utils/utils.dart';

class FeedMenulisField {
  static const createdTime = 'createdTime';
}

class FeedMenulis {
  DateTime createdTime;
  DateTime modifTime;
  String title;
  String id;
  String description;
  String writer;
  String guru;
  String kelas;
  List like = [];
  List comment = [];
  bool isLike = false;
  bool isComment = false;

  FeedMenulis({
    @required this.createdTime,
    @required this.modifTime,
    @required this.title,
    @required this.description,
    @required this.id,
    @required this.writer,
    @required this.guru,
    @required this.kelas,
    @required this.like,
    @required this.comment,
    @required this.isLike,
    @required this.isComment,
  });

  static FeedMenulis fromJson(Map<String, dynamic> json) => FeedMenulis(
        createdTime: Utils.toDateTime(json['createdTime']),
        modifTime: Utils.toDateTime(json['modifTime']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
        writer: json['writer'],
        guru: json['guru'],
        kelas: json['kelas'],
        like: json['like'],
        comment: json['comment'],
        isComment: json['isComment'],
        isLike: json['isLike'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'modifTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'description': description,
        'id': id,
        'writer': writer,
        'guru': guru,
        'kelas': kelas,
        'like': like,
        'comment': comment,
        'isComment': isComment,
        'isLike': isLike,
      };
}
