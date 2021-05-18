import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rusa4/Utils/utils.dart';

class UserRusaField {
  static const akunDibuat = 'akunDibuat';
}

class UserRusa {
  String id;
  String emailGuru;
  String username;
  String emailSiswa;
  String password;
  String passwordConfirm;
  String kelas;
  DateTime akunDibuat;
  String jenisAkun = '';
  String pic = '';
  UserRusa({
    @required this.emailGuru,
    @required this.username,
    @required this.emailSiswa,
    @required this.password,
    @required this.passwordConfirm,
    @required this.kelas,
    @required this.akunDibuat,
    @required this.id,
    @required this.jenisAkun,
    pic,
  });

  UserRusa.fromSnapshot(DocumentSnapshot snapshot)
      : akunDibuat = snapshot['akunDibuat'],
        username = snapshot['username'],
        emailSiswa = snapshot['emailSiswa'],
        emailGuru = snapshot['emailGuru'],
        password = snapshot['password'],
        passwordConfirm = snapshot['passwordConfirm'],
        kelas = snapshot['kelas'],
        id = snapshot['id'],
        jenisAkun = snapshot['jenisAkun'],
        pic = snapshot['pic'];

  static UserRusa fromJson(Map<String, dynamic> json) => UserRusa(
        akunDibuat: Utils.toDateTime(json['akunDibuat']),
        username: json['username'],
        id: json['id'],
        emailSiswa: json['emailSiswa'],
        emailGuru: json['emailGuru'],
        password: json['password'],
        passwordConfirm: json['passwordConfirm'],
        kelas: json['kelas'],
        jenisAkun: json['jenisAkun'],
        pic: json['pic'],
      );

  Map<String, dynamic> toJson(String jenisAkun, String pic) => {
        'akunDibuat': Utils.fromDateTimeToJson(akunDibuat),
        'username': username,
        'emailSiswa': emailSiswa,
        'id': id,
        'emailGuru': emailGuru,
        'password': password,
        'passwordConfirm': passwordConfirm,
        'kelas': kelas,
        'jenisAkun': jenisAkun,
        'pic': 'https://avatars.dicebear.com/api/bottts/' + pic + '.svg'
      };
}
