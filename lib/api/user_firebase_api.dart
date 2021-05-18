import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rusa4/Utils/utils.dart';
import 'package:rusa4/model/user.dart';
// import 'package:rusa4/model/UserRusa.dart';
import 'package:rusa4/model/user_new.dart';

class UserRusaFirebaseApi {
  static Future updateUserRusa(UserRusa userRusa) async {
    final docUserRusa =
        FirebaseFirestore.instance.collection('Users').doc(userRusa.id);

    await docUserRusa.update(userRusa.toJson(userRusa.jenisAkun, userRusa.pic));
  }

  static Future deleteUserRusaGuru(UserRusa userRusa) async {
    final docUserRusa =
        FirebaseFirestore.instance.collection('Users').doc(userRusa.id);

    await docUserRusa.delete();
  }

  static Future updateUserRusaGuru(UserRusa userRusa) async {
    final docUserRusa =
        FirebaseFirestore.instance.collection('Users').doc(userRusa.id);

    await docUserRusa.update(userRusa.toJson(userRusa.jenisAkun, userRusa.pic));
  }

  static Future deleteUserRusa(UserRusa userRusa) async {
    final docUserRusa =
        FirebaseFirestore.instance.collection('Users').doc(userRusa.id);

    await docUserRusa.delete();
  }
}
