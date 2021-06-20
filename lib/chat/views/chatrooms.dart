import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rusa4/chat/helper/constants.dart';
import 'package:rusa4/chat/helper/helperfunctions.dart';
import 'package:rusa4/chat/helper/theme.dart';

import 'package:rusa4/chat/services/database.dart';
import 'package:rusa4/chat/views/chat.dart';
import 'package:rusa4/chat/views/search.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;
  UserRusa user;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.docs[index]
                        .data()['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    chatRoomId: snapshot.data.docs[index].data()['chatRoomId'],
                  );
                })
            : Container(
                child: Center(
                child: Text("belum ada percakapan"),
              ));
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    user = provider.akunRusa;

    return Scaffold(
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Chat(
                          chatRoomId: chatRoomId,
                        )));
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: CustomTheme.colorAccent,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(userName.substring(0, 1),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'OverpassRegular',
                          fontWeight: FontWeight.w700)),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(userName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w300))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
