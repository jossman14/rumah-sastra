import 'package:flutter/material.dart';
import 'package:rusa4/api/materi_firebase_api.dart';
import 'package:rusa4/model/materi.dart';

class MateriProvider extends ChangeNotifier {
  List<Materi> _materi = [];

  // List<Materi> get materis =>
  //     _materi.where((materi) => materi.isDone == false).toList();

  // List<Materi> get materisCompleted =>
  //     _materi.where((materi) => materi.isDone == true).toList();

  void setMateris(List<Materi> materis) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _materi = materis;
        notifyListeners();
      });

  void addMateri(Materi materi) => MateriFirebaseApi.createMateri(materi);

  void removeMateri(Materi materi) => MateriFirebaseApi.deleteMateri(materi);

  void updateMateri(Materi materi, String title, String description,
      String imagegan, String linkVideo, String link) {
    materi.title = title;
    materi.description = description;
    materi.linkVideo = linkVideo;
    materi.imagegan = imagegan;
    materi.link = link;
    materi.createdTime = DateTime.now();

    MateriFirebaseApi.updateMateri(materi);
  }
}
