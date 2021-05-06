import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rusa4/Utils/utils.dart';
import 'package:rusa4/model/materi.dart';

class MateriFirebaseApi {
  static Future createMateri(Materi materi) async {
    // final docMateri = await FirebaseFirestore.instance
    //     .collection('Materi')
    //     .doc(materi.kelas)
    //     .update({
    //   materi.kelas: FieldValue.arrayUnion([materi.toJson()])
    // });
    final docMateri = FirebaseFirestore.instance.collection(materi.kelas).doc();

    materi.id = docMateri.id;
    await docMateri.set(materi.toJson());

    return docMateri.id;

    // return docMateri.id;
  }

  static Stream<List<Materi>> readMateris(String kelas) =>
      FirebaseFirestore.instance
          .collection(kelas)
          .orderBy(MateriField.createdTime, descending: true)
          .snapshots()
          .transform(Utils.transformer(Materi.fromJson));

  static Future updateMateri(Materi materi) async {
    final docMateri =
        FirebaseFirestore.instance.collection(materi.kelas).doc(materi.id);

    await docMateri.update(materi.toJson());
  }

  static Future deleteMateri(Materi materi) async {
    final docMateri =
        FirebaseFirestore.instance.collection(materi.kelas).doc(materi.id);

    await docMateri.delete();
  }
}
