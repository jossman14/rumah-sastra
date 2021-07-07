import 'package:flutter/material.dart';
import 'package:rusa4/api/materi_firebase_api.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/quiz/models/result_model.dart';
import 'package:rusa4/quiz/services/save_result.dart';

class QuizResultProvider extends ChangeNotifier {
  List<QuizResult> _quizResult = [];

  // List<QuizResult> get quizResult =>
  //     _quizResult.where((quizResult) => quizResult.isDone == false).toList();

  // List<QuizResult> get materisCompleted =>
  //     _quizResult.where((quizResult) => quizResult.isDone == true).toList();

  void setQuizResults(List<QuizResult> quizResult) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _quizResult = quizResult;
        notifyListeners();
      });

  void addQuizResult(UserRusa user, QuizResult quizResult) =>
      SaveResultFirebaseApi.createSaveResult(user, quizResult);

  void removeQuizResult(String quizResult) =>
      SaveResultFirebaseApi.deleteSaveResult(quizResult);

  // void updateQuizResult(QuizResult quizResult, String title, String description,
  //     String imagegan, String linkVideo) {
  //   quizResult.title = title;
  //   quizResult.description = description;
  //   quizResult.linkVideo = linkVideo;
  //   quizResult.imagegan = imagegan;

  //   SaveResultFirebaseApi.updateQuizResult(quizResult);
  // }
}
