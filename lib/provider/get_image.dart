import 'package:flutter/material.dart';
import 'package:rusa4/api/feed_menulis_firebase_api.dart';
import 'package:rusa4/api/uji_pemahaman_firebase_api.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/uji_pemahaman.dart';

class GetImageProvider extends ChangeNotifier {
  String _getImage;
  bool _uploadImage;
  GetImageProvider() {
    _getImage = '';
    _uploadImage = false;
  }

  String get getImage => _getImage;

  set getImage(String value) {
    _getImage = value;
    notifyListeners();
  }

  bool get uploadImage => _uploadImage;

  set uploadImage(bool value) {
    _uploadImage = value;
    notifyListeners();
  }
}
