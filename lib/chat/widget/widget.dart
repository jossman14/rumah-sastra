import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/chat/helper/helperfunctions.dart';
import 'package:rusa4/provider/audio_provider.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/auth.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text("Percakapan Rumah Sastra"),
    elevation: 0.0,
    centerTitle: false,
  );
}

munculDialogGan(context, textError) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Kesalahan"),
        content: new Text(textError),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new TextButton(
            child: new Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
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
    title: Text("Rumah Sastra"),
    actions: [
      IconButton(
          icon: Icon(Icons.exit_to_app_rounded),
          onPressed: () {
            playSound();
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

playBtn(BuildContext context) {
  // final provider = Provider.of<AudioProvider>(context, listen: false);
  print("audio di playy");
  // return provider.playGan;
}

cekSoalFunc(BuildContext context) {
  final provider = Provider.of<AudioProvider>(context);

  return provider.cekSoalProvider;
}

tambahCekSoalFunc(BuildContext context) {
  final providerCekSoal = Provider.of<AudioProvider>(context);

  return providerCekSoal.cekSoalProvider = 1;
}

getJawaban(BuildContext context) {
  final provider = Provider.of<AudioProvider>(context, listen: false);

  return provider.jawaban;
}

setJawaban(BuildContext context, value) {
  final providerCekSoal = Provider.of<AudioProvider>(context);

  return providerCekSoal.tambahJawaban = value;
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

bunyiGan() {
  return playSound();
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
