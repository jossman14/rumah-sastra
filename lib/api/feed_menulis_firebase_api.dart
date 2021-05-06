import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rusa4/Utils/utils.dart';
import 'package:rusa4/model/feed_menulis.dart';

class FeedMenulisFirebaseApi {
  static Future createFeedMenulis(FeedMenulis feedMenulis) async {
    // final docFeedMenulis = await FirebaseFirestore.instance
    //     .collection('FeedMenulis')
    //     .doc('Feed')
    //     .update({
    //   'Feed': FieldValue.arrayUnion([feedMenulis.toJson()])
    // });
    final docFeedMenulis = FirebaseFirestore.instance.collection('Feed').doc();

    feedMenulis.id = docFeedMenulis.id;
    await docFeedMenulis.set(feedMenulis.toJson());

    return docFeedMenulis.id;

    // return docFeedMenulis.id;
  }

  static Stream<List<FeedMenulis>> readFeedMenuliss() =>
      FirebaseFirestore.instance
          .collection('Feed')
          .orderBy(FeedMenulisField.createdTime, descending: true)
          .snapshots()
          .transform(Utils.transformer(FeedMenulis.fromJson));

  static Future updateFeedMenulis(FeedMenulis feedMenulis) async {
    final docFeedMenulis =
        FirebaseFirestore.instance.collection('Feed').doc(feedMenulis.id);

    await docFeedMenulis.update(feedMenulis.toJson());
  }

  static Future deleteFeedMenulis(FeedMenulis feedMenulis) async {
    final docFeedMenulis =
        FirebaseFirestore.instance.collection('Feed').doc(feedMenulis.id);

    await docFeedMenulis.delete();
  }
}
