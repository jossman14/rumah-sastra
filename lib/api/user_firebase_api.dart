import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rusa4/Utils/utils.dart';
// import 'package:rusa4/model/UserRusaNew.dart';
import 'package:rusa4/model/user_new.dart';

class UserRusaNewFirebaseApi {
  static Future updateUserRusaNew(UserRusaNew userRusaNew) async {
    final docUserRusaNew = FirebaseFirestore.instance
        .collection('Users')
        .doc(userRusaNew.emailSiswa);

    await docUserRusaNew.update(userRusaNew.toJson());
  }

  static Future deleteUserRusaNewGuru(UserRusaNew userRusaNew) async {
    final docUserRusaNew = FirebaseFirestore.instance
        .collection('Users')
        .doc(userRusaNew.emailGuru);

    await docUserRusaNew.delete();
  }

  static Future updateUserRusaNewGuru(UserRusaNew userRusaNew) async {
    final docUserRusaNew = FirebaseFirestore.instance
        .collection('Users')
        .doc(userRusaNew.emailGuru);

    await docUserRusaNew.update(userRusaNew.toJson());
  }

  static Future deleteUserRusaNew(UserRusaNew userRusaNew) async {
    final docUserRusaNew = FirebaseFirestore.instance
        .collection('Users')
        .doc(userRusaNew.emailSiswa);

    await docUserRusaNew.delete();
  }
}
