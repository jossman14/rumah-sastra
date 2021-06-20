import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/chat/helper/helperfunctions.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/view/auth.dart';
import 'package:translator/translator.dart';

Future<bool> loginSiswaAPI(BuildContext context, UserRusa user) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: user.emailSiswa,
      password: user.password,
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return true;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.message)),
      ),
    );

    munculDialog(context, await translateText(context, e.message));

    return false;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.toString())),
      ),
    );
    return false;
  }
}

Future<bool> loginGuruAPI(BuildContext context, UserRusa user) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: user.emailGuru,
      password: user.password,
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return true;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.message)),
      ),
    );

    munculDialog(context, await translateText(context, e.message));

    return false;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.toString())),
      ),
    );
    return false;
  }
}

Future<bool> createAccountSiswaAPI(BuildContext context, UserRusa user) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.emailSiswa,
      password: user.password,
    );
    FirebaseAuth auth = FirebaseAuth.instance;
    String idGan = auth.currentUser.uid;

    final buatAkun = FirebaseFirestore.instance.collection('Users').doc(idGan);

    user.id = idGan;
    await buatAkun.set(user.toJson("Siswa"));

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return true;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.message)),
      ),
    );

    munculDialog(context, await translateText(context, e.message));

    return false;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.toString())),
      ),
    );
    return false;
  }
}

Future<bool> createAccountGuruAPI(BuildContext context, UserRusa user) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.emailGuru,
      password: user.password,
    );
    FirebaseAuth auth = FirebaseAuth.instance;
    String idGan = auth.currentUser.uid;

    final buatAkun = FirebaseFirestore.instance.collection('Users').doc(idGan);

    user.id = idGan;
    await buatAkun.set(user.toJson("Siswa"));

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return true;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.message)),
      ),
    );

    munculDialog(context, await translateText(context, e.message));

    return false;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.toString())),
      ),
    );
    return false;
  }
}

Future translateText(BuildContext context, String text) async {
  try {
    final translator = GoogleTranslator();

    var translation = await translator.translate(text, to: 'id');
    // Constants.prefs.setString('translateResult', translation);
    return translation.toString();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mohon cek koneksi internet anda'),
      ),
    );
  }
}

Future<bool> logout(BuildContext context) async {
  HelperFunctions.saveUserLoggedInSharedPreference(false);
  HelperFunctions.saveUserNameSharedPreference("");
  HelperFunctions.savesharedPreferenceUserPassword("");
  HelperFunctions.saveUserEmailSharedPreference("");
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthPage()));
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return true;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.message)),
      ),
    );

    munculDialog(context, await translateText(context, e.message));

    return false;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.toString())),
      ),
    );
    return false;
  }
}

munculDialog(context, textError) {
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
