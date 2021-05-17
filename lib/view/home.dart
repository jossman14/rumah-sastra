import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/main_drawer.dart';
import 'package:rusa4/api/flutter_firebase_api.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/view/feed_menulis/view_feed_menulis.dart';
import 'package:rusa4/view/page_guru.dart';
import 'package:rusa4/view/page_siswa.dart';
import 'package:rusa4/view/pilih_kelas.dart';
import 'package:rusa4/view/user_setting/user_setting.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";

  final int selectedPage;

  const HomePage({
    @required this.selectedPage,
    Key key,
  }) : super(key: key);

  // HomePage(int i);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String emailLogin = FirebaseAuth.instance.currentUser.uid;
  // UserRusa user;
  var user = [];
  int select;

  @override
  void initState() {
    super.initState();
    setState(() {
      select = widget.selectedPage;
      // print(select);
    });
  }

  // set user(UserRusa user) {}

  @override
  Widget build(BuildContext context) {
    print('home indek');
    print(select);
    return DefaultTabController(
      initialIndex: widget.selectedPage,
      length: 3,
      child: Scaffold(
        drawer: DrawerApp(),
        appBar: AppBar(
          title: Text("RuSa"),

          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [HexColor('#FF3A00'), HexColor('#FBE27E')],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          bottom: TabBar(
            //isScrollable: true,

            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(icon: Icon(Icons.star), text: 'Feed'),
              Tab(icon: Icon(Icons.face), text: 'Siswa'),
              Tab(icon: Icon(Icons.mail), text: 'Pesan'),
            ],
          ),
          // elevation: 1,
          titleSpacing: 20,
        ),
        body: TabBarView(
          children: [
            ViewFeedMenulis(),
            cekAkun(),
            Container(
              child: Center(
                child: Text('Halaman chat'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PilihKelas pilihKelasCall() => PilihKelas();

  FutureBuilder<QuerySnapshot> cekAkun() {
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
                  print('check login gaaan');
                  print(data.id);
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

          return user[7] == "Guru" ? PageGuru() : PageSiswa();
          // return Container();
        });
  }
}
