import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rusa4/Utils/utils.dart';

class UserRusaNewField {
  static const createdTime = 'akunDibuat';

  // static var createdTime;
}

class UserRusaNew {
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
  UserRusaNew(
      {@required this.emailGuru,
      @required this.username,
      @required this.emailSiswa,
      @required this.password,
      @required this.passwordConfirm,
      @required this.kelas,
      id,
      akunDibuat,
      jenisAkun,
      pic});

  UserRusaNew.fromSnapshot(DocumentSnapshot snapshot)
      : akunDibuat = snapshot['akunDibuat'],
        username = snapshot['username'],
        emailSiswa = snapshot['emailSiswa'],
        emailGuru = snapshot['emailGuru'],
        password = snapshot['password'],
        passwordConfirm = snapshot['passwordConfirm'],
        kelas = snapshot['kelas'],
        jenisAkun = snapshot['jenisAkun'],
        pic = snapshot['pic'];

  static UserRusaNew fromJson(Map<String, dynamic> json) => UserRusaNew(
        akunDibuat: Utils.toDateTime(json['akunDibuat']),
        username: json['username'],
        emailSiswa: json['emailSiswa'],
        emailGuru: json['emailGuru'],
        password: json['password'],
        passwordConfirm: json['passwordConfirm'],
        kelas: json['kelas'],
        jenisAkun: json['jenisAkun'],
        pic: json['pic'],
      );

  Map<String, dynamic> toJson() => {
        'akunDibuat': Utils.fromDateTimeToJson(akunDibuat),
        'username': username,
        'emailSiswa': emailSiswa,
        'emailGuru': emailGuru,
        'password': password,
        'passwordConfirm': passwordConfirm,
        'kelas': kelas,
        'jenisAkun': jenisAkun,
        'pic': pic
      };
}
