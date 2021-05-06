import 'package:flutter/material.dart';
import 'package:rusa4/api/feed_menulis_comment_firebase_api.dart';
import 'package:rusa4/api/feed_menulis_firebase_api.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/feed_menulis_comment.dart';

class FeedMenulisProvider extends ChangeNotifier {
  // FeedMenulis _feedMenulisSingle;
  List<FeedMenulis> _feedMenulis = [];
  List<FeedMenulisComment> _feedMenulisComment = [];

  // List<FeedMenulis> get feedMenuliss =>
  //     _feedMenulis.where((feedMenulis) => feedMenulis.isDone == false).toList();

  // List<FeedMenulis> get feedMenulissCompleted =>
  //     _feedMenulis.where((feedMenulis) => feedMenulis.isDone == true).toList();
  // FeedMenulis get feedMenulisSingle => _feedMenulisSingle;

  // set feedMenulisSingle(FeedMenulis value) {
  //   _feedMenulisSingle = value;
  //   // notifyListeners();
  // }

  // void setFeedMenulis(FeedMenulis feedMenulisSingleQuery) =>
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       feedMenulisSingle = feedMenulisSingleQuery;
  //       notifyListeners();
  //     });

  void setFeedMenuliss(List<FeedMenulis> feedMenuliss) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _feedMenulis = feedMenuliss;
        notifyListeners();
      });
  void setFeedMenulisComment(List<FeedMenulisComment> feedMenulisComment) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _feedMenulisComment = feedMenulisComment;
        notifyListeners();
      });

  void addFeedMenulis(FeedMenulis feedMenulis) =>
      FeedMenulisFirebaseApi.createFeedMenulis(feedMenulis);

  void removeFeedMenulis(FeedMenulis feedMenulis) =>
      FeedMenulisFirebaseApi.deleteFeedMenulis(feedMenulis);

  void updateFeedMenulis(
      FeedMenulis feedMenulis, String title, String description) {
    feedMenulis.title = title;
    feedMenulis.description = description;

    FeedMenulisFirebaseApi.updateFeedMenulis(feedMenulis);
  }

  void likeFeed(FeedMenulis feedMenulis, String liker) {
    feedMenulis.like.add(liker);
    feedMenulis.isLike = true;

    FeedMenulisFirebaseApi.updateFeedMenulis(feedMenulis);
  }

  void removeLikeFeed(FeedMenulis feedMenulis, String liker) {
    feedMenulis.like == null
        ? feedMenulis.like = []
        : feedMenulis.like = feedMenulis.like;
    feedMenulis.like.remove(liker);
    feedMenulis.isLike = false;

    FeedMenulisFirebaseApi.updateFeedMenulis(feedMenulis);
  }

  void commentFeed(FeedMenulis feedMenulis, FeedMenulisComment commenter) {
    feedMenulis.comment.add(commenter.writer);
    feedMenulis.isComment = true;
    FeedMenulisFirebaseApi.updateFeedMenulis(feedMenulis);

    FeedMenulisCommentFirebaseApi.createFeedMenulisComment(
        feedMenulis, commenter);
  }

  void editCommentFeed(FeedMenulis feedMenulis, FeedMenulisComment commenter,
      String description) {
    commenter.description = description;

    FeedMenulisCommentFirebaseApi.updateFeedMenulisComment(
        feedMenulis, commenter);
    FeedMenulisFirebaseApi.updateFeedMenulis(feedMenulis);
  }

  void removeCommentFeed(
      FeedMenulis feedMenulis, FeedMenulisComment commenter) {
    feedMenulis.comment == null
        ? feedMenulis.comment = []
        : feedMenulis.comment = feedMenulis.comment;
    feedMenulis.comment.remove(commenter.writer);
    feedMenulis.isComment = false;

    FeedMenulisCommentFirebaseApi.deleteFeedMenulisComment(
        feedMenulis, commenter);
    FeedMenulisFirebaseApi.updateFeedMenulis(feedMenulis);
  }
}
