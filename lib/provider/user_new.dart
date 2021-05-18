import 'package:flutter/material.dart';
import 'package:rusa4/api/user_firebase_api.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/model/user_new.dart';

class UserRusaProvider extends ChangeNotifier {
  void removeUserRusa(UserRusa userRusa) =>
      UserRusaFirebaseApi.deleteUserRusa(userRusa);

  void updateUserRusa(UserRusa userRusa) {
    UserRusaFirebaseApi.updateUserRusa(userRusa);
  }

  void removeUserRusaGuru(UserRusa userRusa) =>
      UserRusaFirebaseApi.deleteUserRusa(userRusa);

  void updateUserRusaGuru(UserRusa userRusa) {
    UserRusaFirebaseApi.updateUserRusa(userRusa);
  }
}
