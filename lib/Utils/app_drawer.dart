import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/api/flutter_firebase_api.dart';
import 'package:rusa4/provider/email_sign_in.dart';

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
            accountEmail: user[7] == "Guru"
                ? Container(
                    color: Colors.deepOrange,
                    padding: EdgeInsets.all(4.0),
                    child: Text(user[1]),
                  )
                : Container(
                    color: Colors.deepOrange,
                    padding: EdgeInsets.all(4.0),
                    child: Text(user[0]),
                  ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              // backgroundImage: AssetImage('./assets/images/Logo.png'),
              child: Container(
                padding: EdgeInsets.all(12),
                child: SvgPicture.network(
                  user[8],
                  semanticsLabel: 'Profil Pic',
                  placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const CircularProgressIndicator()),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text("Feed"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text("Feed"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text("Feed"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text("Feed"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
