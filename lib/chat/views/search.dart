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

  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .searchByName(searchEditingController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  initiateSearchAllUsername() async {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akunRusa;
    await databaseMethods.searchAllName(user.id).then((snapshot) {
      searchResultSnapshotAllUserName = snapshot;
      setState(() {});
      print("$searchResultSnapshot");
    });
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
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
              );
            })
        : searchResultSnapshotAllUserName != null
            ? ListView.builder(
                shrinkWrap: true,
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
                  );
                })
            : halamanLoadingKecil(context);
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userName) {
    List<String> users = [Constants.myName, userName];

    String chatRoomId = getChatRoomId(Constants.myName, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  username: userName,
                  chatRoomId: chatRoomId,
                )));
  }

  Widget userTile(String userName, String userEmail) {
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
              sendMessage(userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
              child: Text(
                "Message",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    color: Color(0x54FFFFFF),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchEditingController,
                            style: simpleTextStyle(),
                            decoration: InputDecoration(
                                hintText: "cari username ...",
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
    );
  }
}
