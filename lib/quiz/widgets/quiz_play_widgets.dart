import 'package:flutter/material.dart';

class OptionTileBackup extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;

  OptionTileBackup(
      {this.description, this.correctAnswer, this.option, this.optionSelected});

  @override
  _OptionTileBackupState createState() => _OptionTileBackupState();
}

class _OptionTileBackupState extends State<OptionTileBackup> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.optionSelected == widget.description ? true : false,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              height: 28,
              width: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.optionSelected == widget.description
                          ? widget.description == widget.correctAnswer
                              ? Colors.green
                              : Colors.red
                          : Colors.grey,
                      width: 1.5),
                  color: widget.optionSelected == widget.description
                      ? widget.description == widget.correctAnswer
                          ? Colors.green
                          : Colors.red
                      : Colors.white,
                  borderRadius: BorderRadius.circular(24)),
              child: Text(
                widget.option,
                style: TextStyle(
                  color: widget.optionSelected == widget.description
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ),
            // Container(
            //   height: 28,
            //   width: 28,
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //       border: Border.all(
            //           color: widget.optionSelected == widget.description
            //               ? widget.description == widget.correctAnswer
            //                   ? Colors.green
            //                   : Colors.red
            //               : Colors.grey,
            //           width: 1.5),
            //       color: widget.optionSelected == widget.description
            //           ? widget.description == widget.correctAnswer
            //               ? Colors.green
            //               : Colors.red
            //           : Colors.white,
            //       borderRadius: BorderRadius.circular(24)),
            //   child: Text(
            //     widget.option,
            //     style: TextStyle(
            //       color: widget.optionSelected == widget.description
            //           ? Colors.white
            //           : Colors.grey,
            //     ),
            //   ),
            // ),
            SizedBox(
              width: 8,
            ),
            Text(
              widget.description,
              style: TextStyle(fontSize: 17, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}

class OptionTileBackupCek extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  final bool cekJawaban;

  OptionTileBackupCek(
      {this.description,
      this.correctAnswer,
      this.option,
      this.optionSelected,
      this.cekJawaban});

  @override
  _OptionTileBackupCekState createState() => _OptionTileBackupCekState();
}

class _OptionTileBackupCekState extends State<OptionTileBackupCek> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.description == widget.correctAnswer ? true : false,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              height: 28,
              width: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.description == widget.correctAnswer
                          ? Colors.green
                          : Colors.grey,
                      width: 1.5),
                  color: widget.description == widget.correctAnswer
                      ? Colors.green
                      : Colors.white,
                  borderRadius: BorderRadius.circular(24)),
              child: Text(
                widget.option,
                style: TextStyle(
                  color: widget.description == widget.correctAnswer
                      ? Colors.green
                      : Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              widget.description,
              style: TextStyle(fontSize: 17, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}

class NoOfQuestionTile extends StatefulWidget {
  final String text;
  final int number;

  NoOfQuestionTile({this.text, this.number});

  @override
  _NoOfQuestionTileState createState() => _NoOfQuestionTileState();
}

class _NoOfQuestionTileState extends State<NoOfQuestionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)),
                color: Colors.blue),
            child: Text(
              "${widget.number}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                color: Colors.black54),
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
