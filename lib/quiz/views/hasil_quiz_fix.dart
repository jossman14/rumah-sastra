import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/app_drawer.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/quiz/services/database.dart';
import 'package:rusa4/quiz/views/cerita_page.dart';
import 'package:rusa4/quiz/views/create_quiz.dart';
import 'package:rusa4/quiz/views/edit_quiz.dart';
import 'package:rusa4/quiz/views/hasil_home.dart';

class HomeQuizResult extends StatefulWidget {
  final String kelas;
  HomeQuizResult(
    this.kelas,
  );
  @override
  _HomeQuizResultState createState() => _HomeQuizResultState();
}

class _HomeQuizResultState extends State<HomeQuizResult> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: quizStream,
              builder: (context, snapshot) {
                var cekKelas = 0;
                List listKelas = [];
                for (var item in snapshot.data.documents) {
                  if (item.data()['quizKelas'] == widget.kelas) {
                    cekKelas += 1;
                    listKelas.add(item);
                  }
                }
                return snapshot.data == null
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: cekKelas,
                        itemBuilder: (context, index) {
                          return listKelas[index].data()['quizKelas'] ==
                                  widget.kelas
                              ? QuizTile(
                                  imageUrl:
                                      listKelas[index].data()['quizImgUrl'],
                                  title: listKelas[index].data()['quizTitle'],
                                  description:
                                      listKelas[index].data()['quizDesc'],
                                  authorId:
                                      listKelas[index].data()['quizAuthorID'],
                                  kelas: listKelas[index].data()['quizKelas'],
                                  id: listKelas[index].documentID,
                                  hidden: true,
                                  kelasPilih: widget.kelas,
                                )
                              : QuizTile(
                                  imageUrl:
                                      listKelas[index].data()['quizImgUrl'],
                                  title: listKelas[index].data()['quizTitle'],
                                  description:
                                      listKelas[index].data()['quizDesc'],
                                  authorId:
                                      listKelas[index].data()['quizAuthorID'],
                                  kelas: listKelas[index].data()['quizKelas'],
                                  id: listKelas[index].documentID,
                                  hidden: false,
                                  kelasPilih: widget.kelas,
                                );
                        });
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      quizStream = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      appBar: appBarMainGan(context),
      body: quizList(),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => CreateQuiz()));
      //   },
      // ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl, title, id, description, authorId, kelas, kelasPilih;
  final bool hidden;

  Map allAkun;

  List user;

  UserRusa userRusa;

  QuizTile({
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.id,
    @required this.authorId,
    @required this.kelas,
    @required this.hidden,
    @required this.kelasPilih,
  });

  void deleteQuiz(BuildContext context, String quizId) async {
    DatabaseService databaseService = new DatabaseService();

    await databaseService.deleteQuizData(quizId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    allAkun = provider.listAkun;
    user = provider.akun;
    userRusa = provider.akunRusa;
    print("quizHome $id");
    return mainQuiz(context);
  }

  Visibility mainQuiz(BuildContext context) {
    return Visibility(
      visible: hidden && allAkun[authorId].emailGuru == userRusa.emailGuru ||
              authorId == 'k1zCQTqC9KO2HMcH53b9j2HTc9E3'
          ? true
          : false,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HasilHome(
                        kelas: kelasPilih,
                        idQuiz: id,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        color: Colors.black26,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                color: Colors.orange,
                width: MediaQuery.of(context).size.width / 1.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          allAkun[authorId].username,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          color: Colors.deepOrange,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              kelas,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
