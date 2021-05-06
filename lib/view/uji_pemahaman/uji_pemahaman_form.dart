import 'package:flutter/material.dart';

class UjiPemahamanFormWidget extends StatelessWidget {
  final String title;
  final String soal;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedSoal;
  final VoidCallback onSavedUjiPemahaman;

  const UjiPemahamanFormWidget({
    Key key,
    this.title = '',
    this.soal = '',
    @required this.onChangedTitle,
    @required this.onChangedSoal,
    @required this.onSavedUjiPemahaman,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(height: 8),
            buildSoal(),
            SizedBox(height: 16),
            buildButton(),
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title.isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
        ),
      );

  Widget buildSoal() => TextFormField(
        maxLines: 4,
        initialValue: soal,
        onChanged: onChangedSoal,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Soal',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedUjiPemahaman,
          child: Text('Save'),
        ),
      );
}
