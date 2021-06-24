import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/api/flutter_firebase_api.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/view/auth.dart';
import 'package:rusa4/view/home.dart';
import 'package:rusa4/view/user_setting/user_setting.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  // UserRusa user;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;
    print(user[8]);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/200/300"),
                  fit: BoxFit.cover),
              color: Colors.red,
            ),
            margin: EdgeInsets.all(0),
            accountName: Container(
              color: Colors.deepOrange,
              padding: EdgeInsets.all(4.0),
              child: Text(user[3]),
            ),
            accountEmail: Container(
              color: Colors.deepOrange,
              padding: EdgeInsets.all(4.0),
              child: Text(user[7] == 'Guru' ? user[1] : user[0]),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              // backgroundImage: AssetImage('./assets/images/Logo.png'),
              child: Container(
                  padding: user[8][8] != "f"
                      ? EdgeInsets.all(12)
                      : EdgeInsets.all(4),
                  child: user[8][8] != "f"
                      ? SvgPicture.network(
                          user[8],
                          semanticsLabel: 'Profil Pic',
                          placeholderBuilder: (BuildContext context) =>
                              Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: const CircularProgressIndicator()),
                        )
                      : Container(
                          width: 140.0,
                          height: 140.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              image: NetworkImage(user[8]),
                              fit: BoxFit.cover,
                            ),
                          ))),
            ),
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text("Feed"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(selectedPage: 0),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.face),
            title: Text("Materi"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(selectedPage: 1),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text("Pesan"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(selectedPage: 2),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_applications),
            title: Text("Pengaturan Profil"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserSetting()));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded),
            title: Text("Keluar"),
            onTap: () {
              notSet();
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => AuthPage()));
            },
          ),
        ],
      ),
    );
  }
}
