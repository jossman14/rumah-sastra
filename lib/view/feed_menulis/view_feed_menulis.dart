import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/app_drawer.dart';
import 'package:rusa4/api/feed_menulis_firebase_api.dart';
import 'package:rusa4/chat/helper/helperfunctions.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/auth.dart';
import 'package:rusa4/view/feed_menulis/add_feed_menulis.dart';

import 'feed_menulis_widget.dart';

class ViewFeedMenulis extends StatefulWidget {
  const ViewFeedMenulis({
    Key key,
  }) : super(key: key);

  @override
  _ViewFeedMenulisState createState() => _ViewFeedMenulisState();
}

class _ViewFeedMenulisState extends State<ViewFeedMenulis> {
  var user = [];
  UserRusa akunRusa;
  Map allAkun;
  String emailLogin = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);

    user = provider.akun;
    // akunRusa = provider.akunRusa;
    // allAkun = provider.listAkun;

    return feedMenulisHome(context);
  }

  Scaffold feedMenulisHome(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Rumah Sastra"),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app_rounded),
              onPressed: () {
                playSound();
                // Constants.prefs.setBool("loggedIn", false);
                HelperFunctions.saveUserLoggedInSharedPreference(false);
                HelperFunctions.saveUserNameSharedPreference("");
                HelperFunctions.savesharedPreferenceUserPassword("");
                HelperFunctions.saveUserEmailSharedPreference("");
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AuthPage()));
                //
              })
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor('#2980b9'), HexColor('#d35400')],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<List>(
          stream: FeedMenulisFirebaseApi.readFeedMenuliss(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return buildText(
                      'Ada yang error, mohon dicoba lagi nanti ya');
                } else {
                  final feedMenuliss = snapshot.data;

                  final provider = Provider.of<FeedMenulisProvider>(context);
                  provider.setFeedMenuliss(feedMenuliss);

                  return feedMenuliss.isEmpty
                      ? Center(
                          child: Text(
                            'Belum ada konten',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(16),
                          separatorBuilder: (context, index) =>
                              Container(height: 8),
                          itemCount: feedMenuliss.length,
                          itemBuilder: (context, index) {
                            final feedMenulis = feedMenuliss[index];

                            return FeedMenulisWidget(feedMenulis: feedMenulis);
                            // return null;
                          },
                        );
                }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          playSound();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddFeedMenulisDialogWidget()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
