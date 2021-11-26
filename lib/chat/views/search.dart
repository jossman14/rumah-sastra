// import 'package:chatapp/helper/constants.dart';
// import 'package:chatapp/models/user.dart';
// import 'package:chatapp/services/database.dart';
// import 'package:chatapp/views/chat.dart';
// import 'package:chatapp/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/chat/helper/constants.dart';
import 'package:rusa4/chat/services/database.dart';
import 'package:rusa4/chat/views/chat.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;
  QuerySnapshot searchResultSnapshotAllUserName;

  bool isLoading = false;
  bool haveUserSearched = false;

  UserRusa user;

  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .searchByName(searchEditingController.text)
          .then((snapshot) {
        print("$searchResultSnapshot");
        setState(() {
          searchResultSnapshot = snapshot;
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
    searchEditingController.text = '';
  }

  initiateSearchAllUsername() async {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    user = provider.akunRusa;
    await databaseMethods.searchAllName(user.id).then((snapshot) {
      searchResultSnapshotAllUserName = snapshot;
      setState(() {});
      print("$searchResultSnapshot");
    });
  }

  Widget userList() {
    return haveUserSearched
        ? Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchResultSnapshot.docs.length,
                itemBuilder: (context, index) {
                  return userTile(
                    searchResultSnapshot.docs[index].data()["username"],
                    searchResultSnapshot.docs[index].data()[
                        searchResultSnapshot.docs[index].data()["jenisAkun"] ==
                                "Guru"
                            ? "emailGuru"
                            : "emailSiswa"],
                    searchResultSnapshot.docs[index].data()["id"],
                  );
                }),
          )
        : searchResultSnapshotAllUserName != null
            ? Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchResultSnapshotAllUserName.docs.length,
                    itemBuilder: (context, index) {
                      return userTile(
                        searchResultSnapshotAllUserName.docs[index]
                            .data()["username"],
                        searchResultSnapshotAllUserName.docs[index].data()[
                            searchResultSnapshotAllUserName.docs[index]
                                        .data()["jenisAkun"] ==
                                    "Guru"
                                ? "emailGuru"
                                : "emailSiswa"],
                        searchResultSnapshotAllUserName.docs[index]
                            .data()["id"],
                      );
                    }),
              )
            : halamanLoadingKecil(context);
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userName, UserRusa user, String id) {
    List<String> users = [user.id, id];

    String chatRoomId = getChatRoomId(user.id, id);

    Map<String, dynamic> chatRoom = {
      "userID": id,
      "users": users,
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  username: id,
                  chatRoomId: chatRoomId,
                )));
  }

  Widget userTile(String userName, String userEmail, String id) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              Text(
                userEmail,
                style: TextStyle(color: Colors.black87, fontSize: 16),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              sendMessage(userName, user, id);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
              child: Text(
                "Hubungi",
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    initiateSearchAllUsername();
    super.initState();
  }

  Map allAkun;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    user = provider.akunRusa;
    allAkun = provider.listAkun;

    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      color: Color(0x54FFFFFF),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchEditingController,
                              style: simpleTextStyle(),
                              decoration: InputDecoration(
                                  hintText: "cari nama pengguna ...",
                                  hintStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              initiateSearch();
                            },
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          const Color(0x36FFFFFF),
                                          const Color(0x0FFFFFFF)
                                        ],
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.bottomRight),
                                    borderRadius: BorderRadius.circular(40)),
                                padding: EdgeInsets.all(12),
                                child: Icon(FontAwesomeIcons.search)),
                          )
                        ],
                      ),
                    ),
                    userList()
                  ],
                ),
              ),
            ),
    );
  }
}
