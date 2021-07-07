import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rusa4/Utils/utils.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/quiz/models/result_model.dart';

class SaveResultFirebaseApi {
  static Future createSaveResult(UserRusa user, QuizResult quizResult) async {
    final docQuizResult =
        FirebaseFirestore.instance.collection('QuizResult Quiz').doc();

    quizResult.id = docQuizResult.id;
    await docQuizResult.set(quizResult.toJson());

    return docQuizResult.id;
  }

  static Stream<List<QuizResult>> readSaveResult(String kelas) =>
      FirebaseFirestore.instance
          .collection('QuizResult Quiz')
          .orderBy(QuizResultField.createdTime, descending: true)
          .snapshots()
          .transform(Utils.transformer(QuizResult.fromJson));

  static Future updateSaveResult(UserRusa user, QuizResult quizResult) async {
    final docQuizResult = FirebaseFirestore.instance
        .collection('QuizResult Quiz')
        .doc(quizResult.quizId);

    await docQuizResult.update(quizResult.toJson());
  }

  static Future deleteSaveResult(String quizResult) async {
    final docQuizResult = FirebaseFirestore.instance
        .collection('QuizResult Quiz')
        .doc(quizResult);

    await docQuizResult.delete();
  }
}
