import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:rusa4/api/flutter_firebase_api.dart';
import 'package:rusa4/model/user.dart';

class EmailSignInProvider extends ChangeNotifier {
  String _emailGuru;
  String _username;
  String _emailSiswa;
  String _password;
  String _passwordConfirm;
  String _kelas;
  DateTime _akunDibuat;
  List _akun;

  EmailSignInProvider() {
    _emailGuru = '';
    _username = '';
    _emailSiswa = '';
    _password = '';
    _passwordConfirm = '';
    _kelas = '';
    _akunDibuat = DateTime.now();
  }

  String get emailGuru => _emailGuru;

  set emailGuru(String value) {
    _emailGuru = value;
    notifyListeners();
  }

  String get username => _username;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  String get emailSiswa => _emailSiswa;

  set emailSiswa(String value) {
    _emailSiswa = value;
    notifyListeners();
  }

  String get password => _password;

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get passwordConfirm => _passwordConfirm;

  set passwordConfirm(String value) {
    _passwordConfirm = value;
    notifyListeners();
  }

  String get kelas => _kelas;

  set kelas(String value) {
    _kelas = value;
    notifyListeners();
  }

  List get akun => _akun;

  set akun(List value) {
    _akun = value;
    // notifyListeners();
  }

  DateTime get akunDibuat => _akunDibuat;

  set akunDibuat(DateTime value) {
    _akunDibuat = value;
    notifyListeners();
  }

  void setAkun(List user) => WidgetsBinding.instance.addPostFrameCallback((_) {
        _akun = user;
        // notifyListeners();
      });
}
