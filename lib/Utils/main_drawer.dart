import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/api/flutter_firebase_api.dart';
import 'package:rusa4/chat/helper/helperfunctions.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/view/auth.dart';
import 'package:rusa4/view/profileUser.dart';
import 'package:rusa4/view/user_setting/user_setting.dart';

class DrawerApp extends StatefulWidget {
  const DrawerApp({
    Key key,
  }) : super(key: key);

  @override
  _DrawerAppState createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  // UserRusa user;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://picsum.photos/seed/${user[9]}/500/500/?blur"),
                  fit: BoxFit.cover),
              color: Colors.red,
            ),
            margin: EdgeInsets.all(0),
            accountName: Container(
              color: Colors.blue,
              padding: EdgeInsets.all(4.0),
              child: Text(user[3]),
            ),
            accountEmail: Container(
              color: Colors.blue,
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
                          )),
                )),
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
            leading: Icon(Icons.settings_applications),
            title: Text("Profil Pembuat Aplikasi"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileUser()));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded),
            title: Text("Keluar"),
            onTap: () {
              HelperFunctions.saveUserLoggedInSharedPreference(false);
              HelperFunctions.saveUserNameSharedPreference("");
              HelperFunctions.savesharedPreferenceUserPassword("");
              HelperFunctions.saveUserEmailSharedPreference("");
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
