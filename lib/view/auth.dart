import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/api/flutter_firebase_api.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/view/home.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = '/auth';

  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  bool loginSiswa = true;
  bool loginGuru = false;
  bool register = false;

  List user;
  List userFinal;

  TextEditingController _emailGuru = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _emailSiswa = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfirm = TextEditingController();
  TextEditingController _kelas = TextEditingController();

  String _pilihAkun;
  String _pilihKelasSiswa;
  String _pilihKelasGuru;
  String _pilihGuru;

  bool _showForm = false;
  List _listPilihAkun = ["Guru", "Siswa"];
  List _listPilihKelasSiswa = ["VII", "VIII", "IX"];
  List _listPilihKelasGuru = ["VII", "VIII", "IX"];

  bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    // print(user);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.orange),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          shape: BoxShape.circle),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
                        child: Image.asset('./assets/images/Logo.png'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                          loginSiswa
                              ? "Halaman Login Siswa"
                              : loginGuru
                                  ? "Halaman Login Guru"
                                  : register && (_pilihAkun == "Guru")
                                      ? "Halaman Daftar Akun Guru"
                                      : "Halaman Daftar Akun Siswa",
                          style: GoogleFonts.firaSans(
                              fontSize: 30,
                              color: HexColor('#FFFFFF'),
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: checkPage(context),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: !register,
                            child: TextButton(
                              onPressed: () {
                                // Navigator.pushReplacementNamed(context, BuatAkun.routeName);
                                setState(() {
                                  register = !register;
                                  loginGuru = false;
                                  loginSiswa = false;
                                });
                              },
                              child: Text(
                                "Belum punya keduanya?",
                                style: GoogleFonts.firaSans(
                                    fontSize: 15,
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigator.pushReplacementNamed(context, BuatAkun.routeName);
                              // setState() {
                              //   loginGuru = !loginGuru;
                              // }
                              setState(() {
                                loginGuru = !loginGuru;
                                loginSiswa = !loginSiswa;
                              });
                            },
                            child: Text(
                              !loginGuru && !loginSiswa
                                  ? "Sudah punya akun?"
                                  : !loginGuru
                                      ? "Login Guru"
                                      : "Login Siswa",
                              style: GoogleFonts.firaSans(
                                  fontSize: 15,
                                  color: HexColor('#FFFFFF'),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: submitBtn(context),
                    ),
                    register
                        ? SizedBox(height: 36)
                        : SizedBox(
                            height: 36,
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkPage(BuildContext context) {
    if (loginSiswa) {
      return loginSiswaPart(context);
    } else if (loginGuru) {
      return loginGuruPart(context);
    } else if (register) {
      return registerPart(context);
    }
  }

  Column loginSiswaPart(BuildContext context) {
    setState(() {
      loginGuru = false;
      register = false;
    });
    return Column(
      children: [
        TextFormField(
          controller: _emailSiswa,
          decoration: InputDecoration(
            hintText: "Email Siswa",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Email Siswa",
            labelStyle: TextStyle(color: Colors.black),
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
        TextFormField(
          controller: _password,
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (value.isEmpty || value.length < 8) {
              return 'Password minimal 8 karakter';
            } else {
              return null;
            }
          },
          obscureText: _passwordVisible,
        ),
      ],
    );
  }

  Column loginGuruPart(BuildContext context) {
    setState(() {
      loginSiswa = false;
      register = false;
    });
    return Column(
      children: [
        TextFormField(
          controller: _emailGuru,
          decoration: InputDecoration(
            hintText: "Email Guru",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Email Guru",
            labelStyle: TextStyle(color: Colors.black),
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
        TextFormField(
          controller: _password,
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (value.isEmpty || value.length < 8) {
              return 'Password minimal 8 karakter';
            } else {
              return null;
            }
          },
          obscureText: _passwordVisible,
        ),
      ],
    );
  }

  Padding registerPart(BuildContext context) {
    setState(() {
      loginGuru = false;
      loginSiswa = false;
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 16),
            child: Text("Pilih jenis akun"),
          ),
          DropdownButton(
            hint: Text("Pilih jenis akun anda"),
            value: _pilihAkun,
            items: _listPilihAkun.map((value) {
              return DropdownMenuItem(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _pilihAkun = value;
                _showForm = true;
              });
            },
          ),
          Visibility(
            visible: _showForm,
            child: _pilihAkun == "Guru"
                ? registerGuru(context)
                : registerSiswa(context),
          )
        ],
      ),
    );
  }

  Column registerGuru(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _username,
          decoration: InputDecoration(
            hintText: "Username",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Username",
            labelStyle: TextStyle(color: Colors.black),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Form harus diisi';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _emailGuru,
          decoration: InputDecoration(
            hintText: "Email Guru",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Email Guru",
            labelStyle: TextStyle(color: Colors.black),
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
        TextFormField(
          controller: _password,
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (value.isEmpty || value.length < 8) {
              return 'Password minimal 8 karakter';
            } else {
              return null;
            }
          },
          obscureText: _passwordVisible,
        ),
        TextFormField(
          controller: _passwordConfirm,
          decoration: InputDecoration(
            hintText: "Konfirmasi Password",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Konfirmasi Password",
            labelStyle: TextStyle(color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (_password.text != value) {
              return 'Mohon maaf password tidak sama';
            } else {
              return null;
            }
          },
          obscureText: _passwordVisible,
        ),
        DropdownButton(
          hint: Text('Pilih Kelas'), // Not necessary for Option 1
          value: _pilihKelasGuru,
          onChanged: (value) {
            setState(() {
              _pilihKelasGuru = value;
            });
          },
          items: _listPilihKelasGuru.map((value) {
            return DropdownMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList(),
        ),
        TextFormField(
          // controllerdd: _passwordConfirm,
          decoration: InputDecoration(
            hintText: "Kode Guru",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Kode Guru",
            labelStyle: TextStyle(color: Colors.black),
          ),
          validator: (value) {
            if (value != "rumahsastra") {
              return 'Mohon maaf kode anda salah';
            } else {
              return null;
            }
          },
          obscureText: _passwordVisible,
        ),
      ],
    );
  }

  Widget registerSiswa(BuildContext context) {
    return cekAkun(context);
  }

  Column registerSiswaHome(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _username,
          decoration: InputDecoration(
            hintText: "Username",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Username",
            labelStyle: TextStyle(color: Colors.black),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Form harus diisi';
            }
            return null;
          },
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Text("Pilih Guru"),
        ),
        DropdownButton(
          hint: Text(user[0]), // Not necessary for Option 1
          value: _pilihGuru == null ? user[0] : _pilihGuru,
          onChanged: (value) {
            setState(() {
              _pilihGuru = value;
              _emailGuru.text = value;
            });
          },
          items: user.map((value) {
            return DropdownMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList(),
        ),
        TextFormField(
          controller: _emailSiswa,
          decoration: InputDecoration(
            hintText: "Email Siswa",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Email Siswa",
            labelStyle: TextStyle(color: Colors.black),
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
        Container(
          margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Text("Pilih kelas"),
        ),
        DropdownButton(
          hint: Text('Pilih Kelas'), // Not necessary for Option 1
          value: _pilihKelasSiswa,
          onChanged: (value) {
            setState(() {
              _pilihKelasSiswa = value;
            });
          },
          items: _listPilihKelasSiswa.map((value) {
            return DropdownMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList(),
        ),
        TextFormField(
          controller: _password,
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (value.isEmpty || value.length < 8) {
              return 'Password minimal 8 karakter';
            } else {
              return null;
            }
          },
          obscureText: _passwordVisible,
        ),
        TextFormField(
          controller: _passwordConfirm,
          decoration: InputDecoration(
            hintText: "Konfirmasi Password",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Konfirmasi Password",
            labelStyle: TextStyle(color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (_password.text != value) {
              return 'Mohon maaf password tidak sama';
            } else {
              return null;
            }
          },
          obscureText: _passwordVisible,
        ),
      ],
    );
  }

  ElevatedButton submitBtn(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);

    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Loading..."),
            ),
          );
          //provider state
          // _formKey.currentState.save();

          provider.username = _username.text;
          provider.emailGuru = _emailGuru.text;
          provider.emailSiswa = _emailSiswa.text;
          provider.password = _password.text;
          provider.passwordConfirm = _passwordConfirm.text;
          provider.kelas = register && (_pilihAkun == "Guru")
              ? _pilihKelasGuru
              : _pilihKelasSiswa;
          provider.akunDibuat = DateTime.now();

          //insert to provider
          final user = UserRusa(
              akunDibuat: provider.akunDibuat,
              emailSiswa: provider.emailSiswa,
              password: provider.password,
              emailGuru: provider.emailGuru,
              kelas: provider.kelas,
              passwordConfirm: provider.passwordConfirm,
              username: provider.username);

          // provider.akun = getAccount(user) as UserRusa;
          // Constants.prefs.setString('email', provider.emailGuru);

          //create login

          if (loginSiswa) {
            submitLoginSiswa(context, user);
          } else if (loginGuru) {
            submitLoginGuru(context, user);
          } else if (register && (_pilihAkun == "Guru")) {
            submitRegisterGuru(context, user);
          } else if (register && (_pilihAkun == "Siswa")) {
            submitRegisterSiswa(context, user);
          } else {
            print("errorr gan");
          }
        }
      },
      child: Text(loginSiswa
          ? "Login Siswa"
          : loginGuru
              ? "Login Guru"
              : register && (_pilihAkun == "Guru")
                  ? "Daftar Akun Guru"
                  : "Daftar Akun Siswa"),
    );
  }

  Future submitLoginSiswa(BuildContext context, UserRusa user) async {
    //create login
    bool checkLogin = await loginSiswaAPI(context, user);

    //redirect
    if (checkLogin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  Future submitLoginGuru(BuildContext context, UserRusa user) async {
    //create login
    bool checkLogin = await loginGuruAPI(context, user);

    //redirect
    if (checkLogin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  Future submitRegisterSiswa(BuildContext context, UserRusa user) async {
    //create register
    bool checkLogin = await createAccountSiswaAPI(context, user);

    //redirect
    if (checkLogin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  Future submitRegisterGuru(BuildContext context, UserRusa user) async {
    //create register
    bool checkLogin = await createAccountGuruAPI(context, user);

    //redirect
    if (checkLogin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  cekAkun(BuildContext context) {
    user != null ? user.clear() : user = [];
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("Users").get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasData) {
                QuerySnapshot documents = snapshot.data;
                List<DocumentSnapshot> docs = documents.docs;
                user != null ? user.clear() : user = [];
                docs.forEach((data) {
                  if (data.get('jenisAkun') == "Guru") {
                    user.add(data.get('emailGuru'));
                    print(data.get('emailGuru'));
                    print(user);
                  }

                  // user.add(data.get('emailSiswa'));
                  // user.add(data.get('emailGuru'));
                  // user.add(data.get('kelas'));
                  // user.add(data.get('username'));
                  // user.add(data.get('akunDibuat').toDate());
                  // user.add(data.get('password'));
                  // user.add(data.get('passwordConfirm'));
                  // user.add(data.get('jenisAkun'));
                  // user.add(data.get('pic'));

                  // final provider = Provider.of<EmailSignInProvider>(context);

                  // provider.akun = user;
                  // provider.setAkun(user);
                });
              } else {
                print('data tidak ditemukan');
              }
          }

          userFinal = user;

          return registerSiswaHome(context);
          // return Container();
        });
  }
}