import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rusa4/chat/helper/helperfunctions.dart';
import 'package:rusa4/view/auth.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text("Percakapan Rumah Sastra"),
    elevation: 0.0,
    centerTitle: false,
  );
}

Widget appBarMainChat(BuildContext context, username) {
  return AppBar(
    title: Text(username),
    elevation: 0.0,
    centerTitle: false,
  );
}

AppBar appBarMainGan(BuildContext context) {
  return AppBar(
    title: Text("RuSa"),
    actions: [
      IconButton(
          icon: Icon(Icons.exit_to_app_rounded),
          onPressed: () {
            // Constants.prefs.setBool("loggedIn", false);
            notSet();
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AuthPage()));
            //
          })
    ],
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [HexColor('#FF3A00'), HexColor('#FBE27E')],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
    ),
  );
}

Scaffold halamanLoading(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("kami sedang menyiapkan aplikasi untuk anda..."),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

halamanLoadingKecil(BuildContext context) {
  return Container(
    // height: MediaQuery.of(context).size.height,
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("kami sedang menyiapkan aplikasi untuk anda..."),
          ),
        ],
      ),
    ),
  );
}

notSet() {
  HelperFunctions.saveUserLoggedInSharedPreference(false);
  HelperFunctions.saveUserNameSharedPreference("");
  HelperFunctions.savesharedPreferenceUserPassword("");
  HelperFunctions.saveUserEmailSharedPreference("");
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.black87),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black87, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.black87, fontSize: 17);
}
