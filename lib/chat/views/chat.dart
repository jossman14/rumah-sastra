import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/chat/helper/constants.dart';
import 'package:rusa4/chat/services/database.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/view/audioGan.dart';

class Chat extends StatefulWidget {
  final String chatRoomId, username;

  Chat({this.chatRoomId, this.username});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  UserRusa user;

  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  Map allAkun;

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.docs[index].data()["message"],
                    sendByMe:
                        user.id == snapshot.data.docs[index].data()["sendBy"],
                  );
                })
            : Container(
                child: Center(
                  child: Text("chat pesan belum ada"),
                ),
              );
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": user.id,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    user = provider.akunRusa;

    allAkun = provider.listAkun;
    return Scaffold(
      appBar: appBarMainChat(context, allAkun[widget.username].username),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            inputMessage(context),
          ],
        ),
      ),
    );
  }

  Container inputMessage(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        color: Color(0x54FFFFFF),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: messageEditingController,
              style: simpleTextStyle(),
              decoration: InputDecoration(
                  hintText: "Pesan ...",
                  hintStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                  border: InputBorder.none),
            )),
            SizedBox(
              width: 16,
            ),
            GestureDetector(
              onTap: () {
                playSound();
                addMessage();
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
                padding: EdgeInsets.all(8),
                child: Icon(Icons.send),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;

  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [Colors.blue, HexColor('#34495e')],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
