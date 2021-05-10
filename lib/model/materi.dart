import 'package:flutter/cupertino.dart';
import 'package:rusa4/Utils/utils.dart';

class MateriField {
  static const createdTime = 'createdTime';
}

class Materi {
  DateTime createdTime;
  DateTime modifTime;
  String title;
  String id;
  String description;
  String writer;
  String kelas;

  Materi({
    @required this.createdTime,
    @required this.modifTime,
    @required this.title,
    @required this.description,
    @required this.id,
    @required this.writer,
    @required this.kelas,
  });

  static Materi fromJson(Map<String, dynamic> json) => Materi(
        createdTime: Utils.toDateTime(json['createdTime']),
        modifTime: Utils.toDateTime(json['modifTime']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
        writer: json['writer'],
        kelas: json['kelas'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'modifTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'description': description,
        'id': id,
        'writer': writer,
        'kelas': kelas,
      };
}