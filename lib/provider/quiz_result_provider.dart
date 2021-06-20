// import 'package:flutter/material.dart';
// import 'package:rusa4/api/materi_firebase_api.dart';


// class MateriProvider extends ChangeNotifier {
//   List<Materi> _materi = [];

//   // List<Materi> get materis =>
//   //     _materi.where((quizResult) => quizResult.isDone == false).toList();

//   // List<Materi> get materisCompleted =>
//   //     _materi.where((quizResult) => quizResult.isDone == true).toList();

//   void setMateris(List<Materi> materis) =>
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _materi = materis;
//         notifyListeners();
//       });

//   void addMateri(Materi quizResult) => MateriFirebaseApi.createMateri(quizResult);

//   void removeMateri(Materi quizResult) => MateriFirebaseApi.deleteMateri(quizResult);

//   void updateMateri(Materi quizResult, String title, String description,
//       String imagegan, String linkVideo) {
//     quizResult.title = title;
//     quizResult.description = description;
//     quizResult.linkVideo = linkVideo;
//     quizResult.imagegan = imagegan;

//     MateriFirebaseApi.updateMateri(quizResult);
//   }
// }
