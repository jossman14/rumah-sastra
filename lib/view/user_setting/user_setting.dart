import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/app_drawer.dart';
import 'package:rusa4/Utils/utils.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/model/user_new.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/user_new.dart';
import 'package:rusa4/view/auth.dart';

class UserSetting extends StatefulWidget {
  final List pengguna;

  const UserSetting({Key key, @required this.pengguna}) : super(key: key);

  @override
  _UserSettingState createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  String emailLogin = FirebaseAuth.instance.currentUser.uid;

  TextEditingController _penggunaname;

  TextEditingController _emailGuru;
  TextEditingController _kelas;
  TextEditingController _emailSiswa;
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordNew = TextEditingController();
  TextEditingController _passwordConfirm = TextEditingController();
  TextEditingController _passwordCek = TextEditingController();
  bool isEdit = false;
  bool isCorrect = false;
  bool isGanti = false;
  bool _passwordVisible = true;

  List penggunaLocal;
  List userLocal;

  UserRusa hasil;
  // var pengguna = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("RuSa"),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app_rounded),
              onPressed: () {
                // Constants.prefs.setBool("loggedIn", false);
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AuthPage()));
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
      ),
      body: cekAkun(context),
    );
  }

  SafeArea contentSetting(BuildContext context) {
    penggunaLocal = userLocal;
    _emailGuru = TextEditingController(text: penggunaLocal[1]);
    _emailSiswa = TextEditingController(text: penggunaLocal[0]);
    _penggunaname = TextEditingController(text: penggunaLocal[3]);
    _kelas = TextEditingController(text: penggunaLocal[2]);

    _password.text = penggunaLocal[5];
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    "PROFIL PENGGUNA",
                    style: GoogleFonts.firaSans(
                        fontSize: 30,
                        color: HexColor('#2C3E50'),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    padding: EdgeInsets.all(8),
                    color: HexColor('#FF3A00'),
                    child: Text(
                      penggunaLocal[7],
                      style: GoogleFonts.firaSans(
                          fontSize: 20,
                          color: HexColor('#FFFFFF'),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: new Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                              width: 140.0,
                              height: 140.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  image: NetworkImage(
                                      'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 90.0, right: 100.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 25.0,
                                child: new Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //////batas kotak
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Username",
                            style: GoogleFonts.firaSans(
                                fontSize: 14,
                                color: HexColor('#FF3A00'),
                                fontWeight: FontWeight.w700),
                          ),
                          TextFormField(
                            // initialValue: 'ss',
                            enabled: isEdit,
                            controller: _penggunaname,
                            decoration: InputDecoration(
                              hintText: penggunaLocal[3],
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Form harus diisi';
                              }
                              return null;
                            },
                          ),
                          //////batas kotak
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Email Siswa",
                            style: GoogleFonts.firaSans(
                                fontSize: 14,
                                color: HexColor('#FF3A00'),
                                fontWeight: FontWeight.w700),
                          ),
                          TextFormField(
                            // initialValue: formEmailSiswa,
                            enabled: isEdit,
                            controller: _emailSiswa,
                            decoration: InputDecoration(
                              hintText: penggunaLocal[0] == ''
                                  ? '-'
                                  : penggunaLocal[0],
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            validator: (value) {
                              final pattern =
                                  r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                              final regExp = RegExp(pattern);

                              if (!regExp.hasMatch(value)) {
                                return 'Email anda tidak valid';
                              } else {
                                return null;
                              }
                            },
                          ),
                          //////batas kotak
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Email Guru",
                            style: GoogleFonts.firaSans(
                                fontSize: 14,
                                color: HexColor('#FF3A00'),
                                fontWeight: FontWeight.w700),
                          ),
                          TextFormField(
                            // initialValue: formEmailGuru,
                            enabled: isEdit,
                            controller: _emailGuru,
                            decoration: InputDecoration(
                              hintText: penggunaLocal[1],
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            validator: (value) {
                              final pattern =
                                  r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                              final regExp = RegExp(pattern);

                              if (!regExp.hasMatch(value)) {
                                return 'Email anda tidak valid';
                              } else {
                                return null;
                              }
                            },
                          ),
                          //////batas kotak
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Kelas",
                            style: GoogleFonts.firaSans(
                                fontSize: 14,
                                color: HexColor('#FF3A00'),
                                fontWeight: FontWeight.w700),
                          ),
                          TextFormField(
                            // initialValue: formKelas,
                            enabled: isEdit,
                            controller: _kelas,
                            decoration: InputDecoration(
                              hintText: penggunaLocal[2],
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Form harus diisi';
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: !isEdit,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isEdit = !isEdit;
                                    });
                                  },
                                  child: Text("Edit"),
                                ),
                              ),
                              Visibility(
                                visible: isEdit,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      final provider =
                                          Provider.of<UserRusaProvider>(context,
                                              listen: false);

                                      hasil = UserRusa(
                                        akunDibuat: penggunaLocal[4],
                                        id: penggunaLocal[9],
                                        emailGuru: _emailGuru.text,
                                        username: _penggunaname.text,
                                        emailSiswa: _emailSiswa.text,
                                        password: _password.text,
                                        passwordConfirm: _password.text,
                                        kelas: _kelas.text,
                                        jenisAkun: penggunaLocal[7],
                                        pic: penggunaLocal[8],
                                      );

                                      if (penggunaLocal[7] == "Guru") {
                                        provider.updateUserRusaGuru(hasil);
                                      } else {
                                        provider.updateUserRusa(hasil);
                                      }
                                      isEdit = !isEdit;
                                    });
                                  },
                                  child: Text("Simpan"),
                                ),
                              ),
                              SizedBox(width: 16),
                              Visibility(
                                visible: !isGanti,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isGanti = !isGanti;
                                      });
                                    },
                                    child: Text('Ganti Password')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isGanti,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "Ganti Password",
                                    style: GoogleFonts.firaSans(
                                        fontSize: 18,
                                        color: HexColor('#2C3E50'),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Visibility(
                                  visible: !isCorrect,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Password",
                                        style: GoogleFonts.firaSans(
                                            fontSize: 14,
                                            color: HexColor('#FF3A00'),
                                            fontWeight: FontWeight.w700),
                                      ),
                                      TextFormField(
                                        controller: _passwordCek,
                                        decoration: InputDecoration(
                                          hintText: "Masukkan password lama",
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 8) {
                                            return 'Password minimal 8 karakter';
                                          } else {
                                            return null;
                                          }
                                        },
                                        obscureText: _passwordVisible,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: isCorrect,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Password Baru",
                                        style: GoogleFonts.firaSans(
                                            fontSize: 14,
                                            color: HexColor('#FF3A00'),
                                            fontWeight: FontWeight.w700),
                                      ),
                                      TextFormField(
                                        controller: _passwordNew,
                                        decoration: InputDecoration(
                                          hintText: "Masukkan password lama",
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 8) {
                                            return 'Password minimal 8 karakter';
                                          } else {
                                            return null;
                                          }
                                        },
                                        obscureText: _passwordVisible,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        "Konfirmasi Password Baru",
                                        style: GoogleFonts.firaSans(
                                            fontSize: 14,
                                            color: HexColor('#FF3A00'),
                                            fontWeight: FontWeight.w700),
                                      ),
                                      TextFormField(
                                        controller: _passwordConfirm,
                                        decoration: InputDecoration(
                                          hintText: "Konfirmasi password baru",
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == _passwordNew.text) {
                                            return null;
                                          }
                                          if (value.isEmpty ||
                                              value.length < 8) {
                                            return 'Password minimal 8 karakter';
                                          } else {
                                            return null;
                                          }
                                        },
                                        obscureText: _passwordVisible,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: !isCorrect,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (_passwordCek.text ==
                                                  _password.text) {
                                                isCorrect = !isCorrect;
                                                ScaffoldMessenger.of(context)
                                                    .removeCurrentSnackBar();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Password lama salah!')),
                                                );
                                              }
                                            });
                                          },
                                          child: Text('Cek Password')),
                                    ),
                                    Visibility(
                                      visible: isCorrect,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            if (isCorrect) {
                                              final provider =
                                                  Provider.of<UserRusaProvider>(
                                                      context,
                                                      listen: false);

                                              hasil = UserRusa(
                                                id: penggunaLocal[9],
                                                emailGuru: _emailGuru.text,
                                                username: _penggunaname.text,
                                                emailSiswa: _emailSiswa.text,
                                                password: _passwordNew.text,
                                                passwordConfirm:
                                                    _passwordConfirm.text,
                                                kelas: _kelas.text,
                                                akunDibuat: penggunaLocal[4],
                                                jenisAkun: penggunaLocal[7],
                                                pic: penggunaLocal[8],
                                              );

                                              provider.updateUserRusa(hasil);

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Ganti Password Berhasil!')),
                                              );

                                              isCorrect = !isCorrect;
                                              _password.clear();
                                              _passwordNew.clear();
                                              _passwordConfirm.clear();
                                            }

                                            setState(() {});
                                          },
                                          child: Text('Simpan Password')),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isGanti = !isGanti;
                                          });
                                        },
                                        child: Text('Batal ganti password')),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
                    userLocal != null ? userLocal.clear() : userLocal = [];

                    userLocal.add(data.get('emailSiswa'));
                    userLocal.add(data.get('emailGuru'));
                    userLocal.add(data.get('kelas'));
                    userLocal.add(data.get('username'));
                    userLocal.add(data.get('akunDibuat').toDate());
                    userLocal.add(data.get('password'));
                    userLocal.add(data.get('passwordConfirm'));
                    userLocal.add(data.get('jenisAkun'));
                    userLocal.add(data.get('pic'));
                    userLocal.add(data.get('id'));
                  } else {
                    print('data tidak sama');
                  }
                });
              } else {
                print('data tidak ditemukan');
              }
          }
          print('cek akuuunn');
          print(userLocal);
          return contentSetting(context);
          // return Container();
        });
  }
}
