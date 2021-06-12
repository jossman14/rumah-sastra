import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class UserSettingForm extends StatelessWidget {
// String emailLogin = FirebaseAuth.instance.currentUser.uid;

//   TextEditingController _penggunaname;

//   List user;
//   TextEditingController _emailGuru;
//   TextEditingController _kelas;
//   TextEditingController _emailSiswa;
//   TextEditingController _password = TextEditingController();
//   TextEditingController _emailSiswaNew = TextEditingController();
//   TextEditingController _emailGuruNew = TextEditingController();
//   TextEditingController _passwordNew = TextEditingController();
//   TextEditingController _passwordCek = TextEditingController();
//   TextEditingController _passwordConfirm = TextEditingController();

//   bool isEdit = false;
//   bool isCorrect = false;
//   bool isGanti = false;
//   bool _passwordVisible = true;
//   File imageFile;
//   List penggunaLocal;
//   List userLocal;
//   String _pilihGuru;
//   List url;

//   List _listPilihKelasSiswa = ["VII", "VIII", "IX"];
//   String _pilihKelasSiswa;

//   UserRusa hasil;
//   var providerAkun;

  final String jenisAkun;
  final String emailGuru;
  final String kelas;
  final String emailSiswa;
  final String penggunaName;
  final bool isEdit;
  final ValueChanged<String> onChangedEmailGuru;
  final ValueChanged<String> onChangedKelas;
  final ValueChanged<String> onChangedEmailSiswa;
  final ValueChanged<String> onChangedPenggunaName;
  final ValueChanged<bool> onChangedEdit;
  final VoidCallback onSavedMateri;

  const UserSettingForm({
    Key key,
    this.penggunaName = '',
    this.emailGuru = '',
    this.kelas = '',
    this.emailSiswa = '',
    this.jenisAkun = '',
    this.isEdit = false,
    @required this.onChangedEmailGuru,
    @required this.onChangedKelas,
    @required this.onChangedEmailSiswa,
    @required this.onChangedPenggunaName,
    @required this.onChangedEdit,
    @required this.onSavedMateri,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /////batas kotak
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
            enabled: isEdit,
            maxLines: 1,
            initialValue: penggunaName,
            onChanged: onChangedPenggunaName,
            validator: (title) {
              if (title.isEmpty) {
                return 'Nama pengguna tidak boleh kosong';
              }
              return null;
            },
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Judul',
            ),
          ),

          //////batas kotak
          SizedBox(
            height: 16,
          ),

          Visibility(
            visible: jenisAkun == "Guru" ? false : true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email Siswa",
                  style: GoogleFonts.firaSans(
                      fontSize: 14,
                      color: HexColor('#FF3A00'),
                      fontWeight: FontWeight.w700),
                ),
                TextFormField(
                  maxLines: 1,
                  enabled: isEdit,
                  initialValue: emailSiswa,
                  onChanged: onChangedEmailSiswa,
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
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Email Siswa',
                  ),
                ),
              ],
            ),
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

          // akunGuru(context),
          // ////batas kotak
          // SizedBox(
          //   height: 16,
          // ),
          // Text(
          //   "Kelas",
          //   style: GoogleFonts.firaSans(
          //       fontSize: 14,
          //       color: HexColor('#FF3A00'),
          //       fontWeight: FontWeight.w700),
          // ),

          // DropdownButton(
          //   value: _pilihKelasSiswa == null ? _kelas.text : _pilihKelasSiswa,
          //   onChanged: isEdit
          //       ? (value) {
          //           setState(() {
          //             _pilihKelasSiswa = value;
          //             _kelas.text = value;
          //           });
          //         }
          //       : null,
          //   items: _listPilihKelasSiswa.map((value) {
          //     return DropdownMenuItem(
          //       child: Text(value),
          //       value: value,
          //     );
          //   }).toList(),
          // ),
          // SizedBox(
          //   height: 16,
          // ),
        ],
      ),
    );
  }
}
