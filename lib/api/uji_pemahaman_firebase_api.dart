import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rusa4/Utils/utils.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/uji_pemahaman.dart';

class UjiPemahamanFirebaseApi {
  static Future createUjiPemahaman(UjiPemahaman ujiPemahaman) async {
    // final docUjiPemahaman = await FirebaseFirestore.instance
    //     .collection('UjiPemahaman')
    //     .doc('Feed')
    //     .update({
    //   'Feed': FieldValue.arrayUnion([ujiPemahaman.toJson()])
    // });
    final docUjiPemahaman = FirebaseFirestore.instance.collection('Feed').doc();

    ujiPemahaman.id = docUjiPemahaman.id;
    await docUjiPemahaman.set(ujiPemahaman.toJson());

    return docUjiPemahaman.id;

    // return docUjiPemahaman.id;
  }

  static Stream<List<UjiPemahaman>> readUjiPemahamans() =>
      FirebaseFirestore.instance
          .collection('Feed')
          .orderBy(UjiPemahamanField.createdTime, descending: true)
          .snapshots()
          .transform(Utils.transformer(UjiPemahaman.fromJson));

  static Future updateUjiPemahaman(UjiPemahaman ujiPemahaman) async {
    final docUjiPemahaman =
        FirebaseFirestore.instance.collection('Feed').doc(ujiPemahaman.id);

    await docUjiPemahaman.update(ujiPemahaman.toJson());
  }

  static Future deleteUjiPemahaman(UjiPemahaman ujiPemahaman) async {
    final docUjiPemahaman =
        FirebaseFirestore.instance.collection('Feed').doc(ujiPemahaman.id);

    await docUjiPemahaman.delete();
  }
}
