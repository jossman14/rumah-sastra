import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'package:rusa4/Utils/utils.dart';
import 'package:rusa4/model/materi.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/materi_provider.dart';
import 'package:rusa4/provider/quiz_result_provider.dart';
import 'package:rusa4/quiz/models/result_model.dart';
import 'package:rusa4/quiz/services/database.dart';
import 'package:rusa4/quiz/views/quiz_play%20copy.dart';
import 'package:rusa4/quiz/views/quiz_play_hasil.dart';
import 'package:rusa4/view/materi/edit_materi.dart';
import 'package:rusa4/view/materi/see_materi.dart';

class QuizResultWidget extends StatelessWidget {
  final QuizResult quizResult;
  final bool hidden;
  final String idResult, cekIdUser, cekQuizGuru;
  final String cekIdQuiz;

  const QuizResultWidget({
    @required this.quizResult,
    @required this.hidden,
    @required this.idResult,
    @required this.cekIdUser,
    @required this.cekIdQuiz,
    @required this.cekQuizGuru,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return buildQuizResult(context);
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    Map allAkun;

    final user = provider.akun;
    allAkun = provider.listAkun;

    return user[7] == "Guru"
        ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              key: Key(quizResult.id),
              secondaryActions: [
                IconSlideAction(
                  color: Colors.red,
                  caption: 'Hapus',
                  onTap: () => deleteQuizResult(context, idResult, cekIdQuiz),
                  icon: Icons.delete,
                )
              ],
              child: buildQuizResult(context),
            ),
          )
        : buildQuizResult(context);
  }

  Widget buildQuizResult(BuildContext context) {
    Map quizListGan;
    var allAkun;
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    allAkun = provider.listAkun;

    final allQuiz = provider.quizList;

    // print("allQuiz  ${allQuiz[quizResult.quizId]['authorId']}");
    print("check quiz hehehe ${quizResult.correct}");
    final user = provider.akun;
    final userRusa = provider.akunRusa;
    quizListGan = provider.quizList;

    return Visibility(
      visible: cekGuru(hidden, allAkun, allQuiz, userRusa, quizListGan,
          cekQuizGuru, quizResult),
      child: GestureDetector(
        // onTap: () => seeQuizResult(context, quizResult),
        onTap: () {
          final provider =
              Provider.of<EmailSignInProvider>(context, listen: false);
          provider.quizResult = quizResult;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => QuizPlayFullHasil(
                        quizResult.quizId,
                        quizResult.quizName,
                        quizResult.description,
                        quizResult.correct,
                        quizResult.incorrect,
                        quizResult.total,
                      )));
        },
        child: Card(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: HexColor('#2980b9'),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            quizResult.quizName,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                                fontSize: 18,
                                color: HexColor('#ecf0f1'),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        allAkun[quizResult.userId].username,
                        style: GoogleFonts.firaSans(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Center(
                            child: Stack(
                          children: <Widget>[
                            // Stroked text as border.
                            Text(
                              "${quizResult.result.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 45,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 6
                                  ..color = quizResult.result > 60.0
                                      ? HexColor('#27ae60')
                                      : HexColor('#c0392b'),
                              ),
                            ),
                            // Solid text as fill.
                            Text(
                              "${quizResult.result.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 45,
                                color: quizResult.result > 60.0
                                    ? HexColor("#2ecc71")
                                    : HexColor("#e74c3c"),
                              ),
                            ),
                          ],
                        )
                            // child: Text("${(widget.correct / widget.total) * 100}",)
                            // ,
                            ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ListTile(
  //   title: Text(
  //     quizResult.quizId,
  //     style: TextStyle(
  //       fontWeight: FontWeight.bold,
  //       color: Theme.of(context).primaryColor,
  //       fontSize: 22,
  //     ),
  //   ),
  //   subtitle: Row(
  //     children: [
  //       Container(
  //         padding: user[8][8] != "f"
  //             ? EdgeInsets.all(12)
  //             : EdgeInsets.all(4),
  //         child: user[8][8] != "f"
  //             ? Container(
  //                 width: 30,
  //                 height: 30,
  //                 child: SvgPicture.network(
  //                   user[8],
  //                   semanticsLabel: 'Profil Pic',
  //                   placeholderBuilder:
  //                       (BuildContext context) => Container(
  //                           padding:
  //                               const EdgeInsets.all(10.0),
  //                           child:
  //                               const CircularProgressIndicator()),
  //                 ),
  //               )
  //             : Container(
  //                 width: 30,
  //                 height: 30,
  //                 decoration: new BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   image: new DecorationImage(
  //                     image: NetworkImage(user[8]),
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //               ),
  //       ),
  //       SizedBox(
  //         width: 8,
  //       ),
  //       Text(quizResult.username,
  //           style: TextStyle(
  //               fontStyle: FontStyle.italic,
  //               fontWeight: FontWeight.w500)),
  //     ],
  //   ),
  // ),
  void deleteQuizResult(BuildContext context, idResult, cekIdQuiz) {
    DatabaseService databaseService = new DatabaseService();

    final provider = Provider.of<QuizResultProvider>(context, listen: false);
    provider.removeQuizResult(idResult);

    databaseService.deleteUser(cekIdQuiz);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Hasil uji pemahaman dihapus')),
    );
  }

  // void editQuizResult(BuildContext context, QuizResult quizResult) =>
  //     Navigator.of(context).push(
  //       QuizResultalPageRoute(
  //         builder: (context) => EditQuizResultPage(quizResult: quizResult),
  //       ),
  //     );
  // void seeQuizResult(BuildContext context, QuizResult quizResult) =>
  //     Navigator.of(context).push(
  //       QuizResultalPageRoute(
  //         builder: (context) => SeeQuizResultPage(quizResult: quizResult),
  //       ),
  //     );

  cekGuru(hidden, allAkun, allQuiz, userRusa, quizListGan, cekQuizGuru,
      quizResult) {
    if (userRusa.id == 'k1zCQTqC9KO2HMcH53b9j2HTc9E3') {
      return true;
    } else {
      print("cekQuizGuru ${quizResult.quizGuru}");
      if (hidden && quizResult.quizGuru == userRusa.emailGuru) {
        return true;
      } else {
        return false;
      }
    }

    // userRusa.emailGuru == allAkun[materi.userID].emailGuru ||
    //           materi.userID == 'k1zCQTqC9KO2HMcH53b9j2HTc9E3'
  }
}
