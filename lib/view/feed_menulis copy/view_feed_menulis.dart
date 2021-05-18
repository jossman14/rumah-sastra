import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/app_drawer.dart';
import 'package:rusa4/api/feed_menulis_firebase_api.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/view/auth.dart';
import 'package:rusa4/view/feed_menulis/add_feed_menulis.dart';
import 'package:rusa4/view/feed_menulis/feed_menulis_widget.dart';

class ViewFeedMenulis extends StatefulWidget {
  const ViewFeedMenulis({
    Key key,
  }) : super(key: key);

  @override
  _ViewFeedMenulisState createState() => _ViewFeedMenulisState();
}

class _ViewFeedMenulisState extends State<ViewFeedMenulis> {
  List user;
  String emailLogin = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return cekAkun(context);
  }

  FutureBuilder<QuerySnapshot> cekAkun(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("Users").get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text("hasilnya none"),
              );
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasData) {
                QuerySnapshot documents = snapshot.data;
                List<DocumentSnapshot> docs = documents.docs;
                docs.forEach((data) {
                  if (data.id == emailLogin) {
                    user.clear();
                    user.add(data.get('emailSiswa'));
                    user.add(data.get('emailGuru'));
                    user.add(data.get('kelas'));
                    user.add(data.get('username'));
                    user.add(data.get('akunDibuat').toDate());
                    user.add(data.get('password'));
                    user.add(data.get('passwordConfirm'));
                    user.add(data.get('jenisAkun'));
                    user.add(data.get('pic'));
                    user.add(data.get('id'));

                    final provider = Provider.of<EmailSignInProvider>(context);

                    provider.akun = user;
                    provider.setAkun(user);
                  } else {
                    print('data tidak sama');
                  }
                });
              } else {
                print('data tidak ditemukan');
              }
          }

          return feedMenulisHome(context);
          // return Container();
        });
  }

  Scaffold feedMenulisHome(BuildContext context) {
    return Scaffold(
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
                            'Belum ada feed.',
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
                          },
                        );
                }
            }
          },
        ),
      ),
      floatingActionButton: user[7] == "Guru"
          ? FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddFeedMenulisDialogWidget()));
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
