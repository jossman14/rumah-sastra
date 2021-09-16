import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/feed_menulis_comment.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/feed_menulis/edit_feed_menulis.dart';
import 'package:rusa4/view/feed_menulis/see_feed_menulis.dart';

class FeedMenulisWidget extends StatefulWidget {
  final FeedMenulis feedMenulis;

  const FeedMenulisWidget({
    @required this.feedMenulis,
    Key key,
  }) : super(key: key);

  @override
  _FeedMenulisWidgetState createState() => _FeedMenulisWidgetState();
}

class _FeedMenulisWidgetState extends State<FeedMenulisWidget> {
  TextEditingController _commentarController = TextEditingController();
  var provider, providerComment;
  List user;

  Map allAkun;

  @override
  void initState() {
    // Intl.defaultLocale = 'es';
    initializeDateFormatting("id_ID");
    super.initState();
    setState(() {
      provider = Provider.of<EmailSignInProvider>(context, listen: false);
      providerComment =
          Provider.of<FeedMenulisProvider>(context, listen: false);

      user = provider.akun;
      allAkun = provider.listAkun;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(allAkun["k1zCQTqC9KO2HMcH53b9j2HTc9E3"].id);
    // print(allAkun[widget.feedMenulis.userID].id);
    // print(user[9]);
    return user[9] == allAkun[widget.feedMenulis.userID].id
        ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              key: Key(widget.feedMenulis.id),
              actions: [
                IconSlideAction(
                  color: Colors.green,
                  onTap: () => editFeedMenulis(context, widget.feedMenulis),
                  caption: 'Ubah',
                  icon: Icons.edit,
                )
              ],
              secondaryActions: [
                IconSlideAction(
                  color: Colors.red,
                  caption: 'Hapus',
                  onTap: () => deleteFeedMenulis(context, widget.feedMenulis),
                  icon: Icons.delete,
                )
              ],
              child: buildFeedMenulis(context),
            ),
          )
        : buildFeedMenulis(context);
  }

  Widget buildFeedMenulis(BuildContext context) {
    return GestureDetector(
      onTap: () => seeFeedMenulis(context, widget.feedMenulis),
      child: Card(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        DateFormat("EEEE, d MMMM yyyy kk:mm", "id_ID")
                            .format(widget.feedMenulis.createdTime),
                        // Text(widget.feedMenulis.createdTime.day.toString(),
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500)),
                    ListTile(
                      title: Text(
                        widget.feedMenulis.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Container(
                              padding:
                                  allAkun[widget.feedMenulis.userID].pic[8] !=
                                          "f"
                                      ? EdgeInsets.all(12)
                                      : EdgeInsets.all(4),
                              child: allAkun[widget.feedMenulis.userID]
                                          .pic[8] !=
                                      "f"
                                  ? Container(
                                      width: 30,
                                      height: 30,
                                      child: SvgPicture.network(
                                        allAkun[widget.feedMenulis.userID].pic,
                                        semanticsLabel: 'Profil Pic',
                                        placeholderBuilder:
                                            (BuildContext context) => Container(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child:
                                                    const CircularProgressIndicator()),
                                      ),
                                    )
                                  : Container(
                                      width: 30,
                                      height: 30,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          image: NetworkImage(
                                              allAkun[widget.feedMenulis.userID]
                                                  .pic),
                                          fit: BoxFit.cover,
                                        ),
                                      ))),
                          SizedBox(
                            width: 8,
                          ),
                          Text(allAkun[widget.feedMenulis.userID].username,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.thumb_up_outlined),
                          color: widget.feedMenulis.like.contains(user[9])
                              ? Colors.blue
                              : Colors.black,
                          onPressed: () {
                            playSound();
                            final provider = Provider.of<FeedMenulisProvider>(
                                context,
                                listen: false);

                            !widget.feedMenulis.like.contains(user[9])
                                ? provider.likeFeed(widget.feedMenulis, user[9])
                                : provider.removeLikeFeed(
                                    widget.feedMenulis, user[9]);
                          },
                        ),
                        Text(widget.feedMenulis.like == null
                            ? "0"
                            : widget.feedMenulis.like.length.toString()),
                        IconButton(
                          icon: Icon(Icons.comment_outlined),
                          color: widget.feedMenulis.comment.contains(user[9])
                              ? Colors.blue
                              : Colors.black,
                          onPressed: () {
                            playSound();
                            buildAlertDialog();
                          },
                        ),
                        Text(widget.feedMenulis.comment == null
                            ? "0"
                            : widget.feedMenulis.comment.length.toString()),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildAlertDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Tambah komentar'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(
                  //   height: 5,
                  // ),
                  buildComment(),
                  SizedBox(
                    height: 16,
                  ),
                  buildButton(),
                ],
              ));
        });
  }

  void deleteFeedMenulis(BuildContext context, FeedMenulis feedMenulis) {
    final provider = Provider.of<FeedMenulisProvider>(context, listen: false);
    provider.removeFeedMenulis(feedMenulis);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Konten dihapus')),
    );
  }

  void editFeedMenulis(BuildContext context, FeedMenulis feedMenulis) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditFeedMenulisPage(feedMenulis: feedMenulis),
        ),
      );

  void seeFeedMenulis(BuildContext context, FeedMenulis feedMenulis) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SeeFeedMenulisPage(feedMenulis: feedMenulis),
        ),
      );

  Widget buildComment() {
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
            final komentar = FeedMenulisComment(
                id: DateTime.now().toString(),
                createdTime: DateTime.now(),
                description: _commentarController.text,
                userId: user[9],
                writer: user[3]);

            providerComment.commentFeed(widget.feedMenulis, komentar);
            _commentarController.text = '';
            Navigator.pop(context);
          },
          child: Text('Simpan'),
        ),
      );
}
