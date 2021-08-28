import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rusa4/api/feed_menulis_firebase_api.dart';
import 'package:rusa4/api/uji_pemahaman_firebase_api.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/uji_pemahaman.dart';

class GetImageProvider extends ChangeNotifier {
  String _getImage;
  bool _uploadImage;
  List _imageOperation;
  File _fileImage;
  bool _selesai;
  GetImageProvider() {
    _getImage = '';
    _uploadImage = false;
    _selesai = false;
    _imageOperation = ["", "", ""];
  }

  bool get selesai => _selesai;

  set selesai(bool value) {
    _selesai = value;
    // notifyListeners();
  }

  String get getImage => _getImage;

  set getImage(String value) {
    _getImage = value;
    // notifyListeners();
  }

  File get fileImage => _fileImage;

  set fileImage(File value) {
    _fileImage = value;
    notifyListeners();
  }

  bool get uploadImage => _uploadImage;

  set uploadImage(bool value) {
    _uploadImage = value;
    notifyListeners();
  }

  List get imageOperation => _imageOperation;

  set imageOperation(List value) {
    _imageOperation = value;
    notifyListeners();
  }
}
