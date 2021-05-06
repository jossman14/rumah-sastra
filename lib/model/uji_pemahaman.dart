import 'package:flutter/cupertino.dart';
import 'package:rusa4/Utils/utils.dart';

class UjiPemahamanField {
  static const createdTime = 'createdTime';
}

class UjiPemahaman {
  DateTime createdTime;
  String title;
  String id;
  List soal;
  List jawaban;
  String guru;
  String kelas;

  UjiPemahaman({
    @required this.createdTime,
    @required this.title,
    @required this.soal,
    @required this.id,
    @required this.jawaban,
    @required this.guru,
    @required this.kelas,
  });

  static UjiPemahaman fromJson(Map<String, dynamic> json) => UjiPemahaman(
        createdTime: Utils.toDateTime(json['createdTime']),
        title: json['title'],
        soal: json['soal'],
        id: json['id'],
        jawaban: json['jawaban'],
        guru: json['guru'],
        kelas: json['kelas'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'soal': soal,
        'id': id,
        'jawaban': jawaban,
        'guru': guru,
        'kelas': kelas,
      };
}
