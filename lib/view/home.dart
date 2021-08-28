import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/main_drawer.dart';
import 'package:rusa4/chat/views/chatrooms.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/view/feed_menulis/view_feed_menulis.dart';
import 'package:rusa4/view/page_guru.dart';
import 'package:rusa4/view/page_siswa.dart';
import 'package:rusa4/view/pilih_kelas.dart';

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
    select = widget.selectedPage;
  }

  // set user(UserRusa user) {}

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    user = provider.akun;
    print(provider.daftarEmailGuru);
    return DefaultTabController(
      initialIndex: widget.selectedPage,
      length: 3,
      child: Scaffold(
        drawer: DrawerApp(),
        appBar: AppBar(
          title: Text("Rumah Sastra"),

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
              Tab(
                  icon: Icon(Icons.face),
                  text: user[7] == "Guru" ? "Guru" : 'Siswa'),
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
            ChatRoom(),
          ],
        ),
      ),
    );
  }

  PilihKelas pilihKelasCall() => PilihKelas();

  cekAkun() {
    return user[7] == "Guru" ? PageGuru() : PageSiswa();
  }
}
