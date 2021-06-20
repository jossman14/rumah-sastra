import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rusa4/model/user.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance
        .collection("Users")
        .add(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email, UserRusa user) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .where(user.jenisAkun == "Guru" ? "emailGuru" : "emailSiswa",
            isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("Users")
        .where('username', arrayContains: searchField)
        .get();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
