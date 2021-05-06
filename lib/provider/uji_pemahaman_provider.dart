import 'package:flutter/material.dart';
import 'package:rusa4/api/feed_menulis_firebase_api.dart';
import 'package:rusa4/api/uji_pemahaman_firebase_api.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/uji_pemahaman.dart';

class UjiPemahamanProvider extends ChangeNotifier {
  List<UjiPemahaman> _ujiPemahaman = [];

  // List<UjiPemahaman> get ujiPemahamans =>
  //     _ujiPemahaman.where((ujiPemahaman) => ujiPemahaman.isDone == false).toList();

  // List<UjiPemahaman> get ujiPemahamansCompleted =>
  //     _ujiPemahaman.where((ujiPemahaman) => ujiPemahaman.isDone == true).toList();

  void setUjiPemahamans(List<UjiPemahaman> ujiPemahamans) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _ujiPemahaman = ujiPemahamans;
        notifyListeners();
      });

  void addUjiPemahaman(UjiPemahaman ujiPemahaman) =>
      UjiPemahamanFirebaseApi.createUjiPemahaman(ujiPemahaman);

  void removeUjiPemahaman(UjiPemahaman ujiPemahaman) =>
      UjiPemahamanFirebaseApi.deleteUjiPemahaman(ujiPemahaman);

  void updateUjiPemahaman(
      UjiPemahaman ujiPemahaman, String title, List soal, List jawaban) {
    ujiPemahaman.title = title;
    ujiPemahaman.soal = soal;
    ujiPemahaman.jawaban = jawaban;

    UjiPemahamanFirebaseApi.updateUjiPemahaman(ujiPemahaman);
  }
}
