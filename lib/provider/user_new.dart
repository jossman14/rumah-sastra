import 'package:flutter/material.dart';
import 'package:rusa4/api/user_firebase_api.dart';
// import 'package:rusa4/api/userRusaNew_firebase_api.dart';
// import 'package:rusa4/model/userRusaNew.dart';
import 'package:rusa4/model/user_new.dart';

class UserRusaNewProvider extends ChangeNotifier {
  void removeUserRusaNew(UserRusaNew userRusaNew) =>
      UserRusaNewFirebaseApi.deleteUserRusaNew(userRusaNew);

  void updateUserRusaNew(UserRusaNew userRusaNew) {
    UserRusaNewFirebaseApi.updateUserRusaNew(userRusaNew);
  }

  void removeUserRusaNewGuru(UserRusaNew userRusaNew) =>
      UserRusaNewFirebaseApi.deleteUserRusaNew(userRusaNew);

  void updateUserRusaNewGuru(UserRusaNew userRusaNew) {
    UserRusaNewFirebaseApi.updateUserRusaNew(userRusaNew);
  }
}
