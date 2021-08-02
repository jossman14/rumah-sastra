import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/feed_menulis_comment.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/feed_menulis/edit_feed_menulis.dart';
import 'package:rusa4/view/feed_menulis/see_feed_menulis.dart';

class FeedMenulisCommentWidget extends StatefulWidget {
  final FeedMenulisComment feedMenulisComment;
  final FeedMenulis feedMenulis;

  const FeedMenulisCommentWidget({
    @required this.feedMenulisComment,
    @required this.feedMenulis,
    Key key,
  }) : super(key: key);

  @override
  _FeedMenulisCommentWidgetState createState() =>
      _FeedMenulisCommentWidgetState();
}

class _FeedMenulisCommentWidgetState extends State<FeedMenulisCommentWidget> {
  TextEditingController _commentarController = TextEditingController();
  var provider;
  List user;

  Map allAkun;

  @override
  void initState() {
    super.initState();
    setState(() {
      provider = Provider.of<EmailSignInProvider>(context, listen: false);

      user = provider.akun;
      allAkun = provider.listAkun;
    });
  }

  @override
  Widget build(BuildContext context) {
    String idUser = FirebaseAuth.instance.currentUser.uid;

    return user[9] == allAkun[widget.feedMenulisComment.id].id
        ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              key: Key(widget.feedMenulisComment.id),
              actions: [
                IconSlideAction(
                  color: Colors.green,
                  onTap: () {
                    editAlertDialog();
                  },
                  caption: 'Ubah',
                  icon: Icons.edit,
                )
              ],
              secondaryActions: [
                IconSlideAction(
                  color: Colors.red,
                  caption: 'Hapus',
                  onTap: () => deleteFeedMenulisComment(
                      context, widget.feedMenulisComment),
                  icon: Icons.delete,
                )
              ],
              child: buildFeedMenulisComment(context),
            ),
          )
        : buildFeedMenulisComment(context);
  }

  Widget buildFeedMenulisComment(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Container(
          color: HexColor('#ecf0f1'),
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        widget.feedMenulisComment.description,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Container(
                              padding: allAkun[widget.feedMenulisComment.id]
                                          .pic[8] !=
                                      "f"
                                  ? EdgeInsets.all(12)
                                  : EdgeInsets.all(4),
                              child: allAkun[widget.feedMenulisComment.id]
                                          .pic[8] !=
                                      "f"
                                  ? SvgPicture.network(
                                      allAkun[widget.feedMenulisComment.id].pic,
                                      semanticsLabel: 'Profil Pic',
                                      placeholderBuilder:
                                          (BuildContext context) => Container(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child:
                                                  const CircularProgressIndicator()),
                                    )
                                  : Container(
                                      width: 30,
                                      height: 30,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          image: NetworkImage(allAkun[
                                                  widget.feedMenulisComment.id]
                                              .pic),
                                          fit: BoxFit.cover,
                                        ),
                                      ))),
                          SizedBox(
                            width: 8,
                          ),
                          Text(widget.feedMenulis.comment[0],
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteFeedMenulisComment(
      BuildContext context, FeedMenulisComment feedMenulisComment) {
    final provider = Provider.of<FeedMenulisProvider>(context, listen: false);
    provider.removeCommentFeed(widget.feedMenulis, feedMenulisComment);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Komentar Feed Menulis dihapus')),
    );
  }

  // void editFeedMenulisComment(
  //         BuildContext context, FeedMenulisComment feedMenulisComment) =>
  // Navigator.of(context).push(
  //   MaterialPageRoute(
  //     builder: (context) => EditFeedMenulisCommentPage(
  //         feedMenulisComment: feedMenulisComment),
  //   ),
  // );

  // void seeFeedMenulisComment(
  //         BuildContext context, FeedMenulisComment feedMenulisComment) =>
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) =>
  //             {SeeFeedMenulisCommentPage(feedMenulisComment: feedMenulisComment)},
  //       ),
  //     );
  editAlertDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Tambah komentar'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  editComment(),
                  SizedBox(
                    height: 16,
                  ),
                  buildButton(),
                ],
              ));
        });
  }

  Widget editComment() {
    _commentarController.text = widget.feedMenulisComment.description;
    return TextFormField(
      maxLines: 4,
      controller: _commentarController,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Komentar',
      ),
    );
  }

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: () {
            playSound();
            final provider =
                Provider.of<FeedMenulisProvider>(context, listen: false);
            provider.editCommentFeed(widget.feedMenulis,
                widget.feedMenulisComment, _commentarController.text);
            // _commentarController.text = '';
            Navigator.pop(context);
          },
          child: Text('Simpan'),
        ),
      );
}
