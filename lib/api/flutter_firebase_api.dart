import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/constant.dart';
import 'package:rusa4/Utils/utils.dart';
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
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.emailSiswa)
        .set(user.toJson("Siswa", user.username));
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return true;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.message)),
      ),
    );
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
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.emailGuru)
        .set(user.toJson("Guru", user.username));
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return true;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.message)),
      ),
    );
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

Future<UserRusa> getAccount(BuildContext context) async {
  try {
    var email = FirebaseAuth.instance.currentUser.email;
    print('proses gan ' + email);
    var account =
        await FirebaseFirestore.instance.collection('Users').doc(email).get();
    var data = UserRusa.fromSnapshot(account);
    return data;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.message)),
      ),
    );
    // return false;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await translateText(context, e.toString())),
      ),
    );
    // return false;
  }
}

Future<DocumentSnapshot> getUserInfo() async {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  return await FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseUser.email)
      .get();
}

FutureBuilder<QuerySnapshot> cekAkun() {
  String emailLogin = FirebaseAuth.instance.currentUser.email;

  var user = [];
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

        return null;
        // return Container();
      });
}
