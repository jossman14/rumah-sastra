import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rusa4/Utils/utils.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/quiz/models/result_model.dart';

class SaveResultFirebaseApi {
  static Future createSaveResult(UserRusa user, QuizResult quizResult) async {
    final docQuizResult = FirebaseFirestore.instance
        .collection('QuizResult ${user.kelas} Quiz')
        .doc(quizResult.quizId)
        .collection(user.id)
        .doc();

    quizResult.id = docQuizResult.id;
    await docQuizResult.set(quizResult.toJson());

    return docQuizResult.id;
  }

  static readSaveResults(UserRusa user) async =>
      await FirebaseFirestore.instance
          .collection('QuizResult ${user.kelas} Quiz')
          .snapshots();

  static Future updateSaveResult(UserRusa user, QuizResult quizResult) async {
    final docQuizResult = FirebaseFirestore.instance
        .collection('QuizResult ${user.kelas} Quiz')
        .doc(quizResult.quizId)
        .collection(user.id)
        .doc(quizResult.id);

    await docQuizResult.update(quizResult.toJson());
  }

  static Future deleteSaveResult(UserRusa user, QuizResult quizResult) async {
    final docQuizResult = FirebaseFirestore.instance
        .collection('QuizResult ${user.kelas} Quiz')
        .doc(quizResult.quizId)
        .collection(user.id)
        .doc(quizResult.id);

    await docQuizResult.delete();
  }
}
