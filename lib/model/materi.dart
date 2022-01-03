import 'package:flutter/cupertino.dart';
import 'package:rusa4/Utils/utils.dart';

class MateriField {
  static const createdTime = 'createdTime';
}

class Materi {
  DateTime createdTime;
  DateTime modifTime;
  String title;
  String linkVideo;
  String id;
  String description;
  String imagegan;
  String link;
  String writer;
  String kelas;
  String userID;
  String deskripsiMarkdownForm;

  Materi({
    @required this.createdTime,
    @required this.modifTime,
    @required this.linkVideo,
    @required this.title,
    @required this.description,
    @required this.imagegan,
    @required this.id,
    @required this.writer,
    @required this.kelas,
    @required this.link,
    @required this.userID,
  });

  static Materi fromJson(Map<String, dynamic> json) => Materi(
        createdTime: Utils.toDateTime(json['createdTime']),
        modifTime: Utils.toDateTime(json['modifTime']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
        writer: json['writer'],
        kelas: json['kelas'],
        linkVideo: json['linkVideo'],
        imagegan: json['imagegan'],
        userID: json['userID'],
        link: json['link'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'modifTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'description': description,
        'id': id,
        'writer': writer,
        'kelas': kelas,
        'linkVideo': linkVideo,
        'imagegan': imagegan,
        'userID': userID,
        'link': link,
      };
}
