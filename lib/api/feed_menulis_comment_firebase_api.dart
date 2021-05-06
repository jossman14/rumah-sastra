import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rusa4/Utils/utils.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/feed_menulis_comment.dart';

class FeedMenulisCommentFirebaseApi {
  static Future createFeedMenulisComment(
      FeedMenulis feedMenulis, FeedMenulisComment feedMenulisComment) async {
    final docFeedMenulisComment = FirebaseFirestore.instance
        .collection('Feed')
        .doc(feedMenulis.id)
        .collection('Comments')
        .doc();

    print('add comment to firebase');

    feedMenulisComment.id = docFeedMenulisComment.id;
    await docFeedMenulisComment.set(feedMenulisComment.toJson());

    return docFeedMenulisComment.id;

    // return docFeedMenulisComment.id;
  }

  static Stream<List<FeedMenulisComment>> readFeedMenulisComments(
          FeedMenulis feedMenulis) =>
      FirebaseFirestore.instance
          .collection('Feed')
          .doc(feedMenulis.id)
          .collection('Comments')
          .orderBy(FeedMenulisCommentField.createdTime, descending: true)
          .snapshots()
          .transform(Utils.transformer(FeedMenulisComment.fromJson));

  static Future updateFeedMenulisComment(
      FeedMenulis feedMenulis, FeedMenulisComment feedMenulisComment) async {
    final docFeedMenulisComment = FirebaseFirestore.instance
        .collection('Feed')
        .doc(feedMenulis.id)
        .collection('Comments')
        .doc(feedMenulisComment.id);

    await docFeedMenulisComment.update(feedMenulisComment.toJson());
  }

  static Future deleteFeedMenulisComment(
      FeedMenulis feedMenulis, FeedMenulisComment feedMenulisComment) async {
    final docFeedMenulisComment = FirebaseFirestore.instance
        .collection('Feed')
        .doc(feedMenulis.id)
        .collection('Comments')
        .doc(feedMenulisComment.id);

    await docFeedMenulisComment.delete();
  }
}
