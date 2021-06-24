import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/api/feed_menulis_comment_firebase_api.dart';
import 'package:rusa4/api/feed_menulis_firebase_api.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/feed_menulis_comment.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/view/feed_menulis/edit_feed_menulis.dart';
import 'package:rusa4/view/feed_menulis/feed_menulis_comment_widget.dart';

class SeeFeedMenulisPage extends StatefulWidget {
  final FeedMenulis feedMenulis;

  const SeeFeedMenulisPage({Key key, @required this.feedMenulis})
      : super(key: key);
  @override
  _SeeFeedMenulisPageState createState() => _SeeFeedMenulisPageState();
}

class _SeeFeedMenulisPageState extends State<SeeFeedMenulisPage> {
  TextEditingController _commentarController = TextEditingController();
  var provider;
  List user;

  String title;
  String description;

  @override
  void initState() {
    super.initState();

    title = widget.feedMenulis.title;
    description = widget.feedMenulis.description;

    setState(() {
      provider = Provider.of<EmailSignInProvider>(context, listen: false);

      user = provider.akun;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: user[7] == "Guru"
            ? [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => EditFeedMenulisPage(
                            feedMenulis: widget.feedMenulis),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    final provider = Provider.of<FeedMenulisProvider>(context,
                        listen: false);
                    provider.removeFeedMenulis(widget.feedMenulis);

                    Navigator.of(context).pop();
                  },
                )
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    // SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.thumb_up_outlined,
                            // size: 1,
                          ),
                          color: widget.feedMenulis.isLike == true
                              ? Colors.blue
                              : Colors.black,
                          onPressed: () {
                            final provider = Provider.of<FeedMenulisProvider>(
                                context,
                                listen: false);
                            // print('hehe');
                            // print(widget.feedMenulis.isLike);
                            widget.feedMenulis.isLike == false
                                ? provider.likeFeed(widget.feedMenulis, user[3])
                                : provider.removeLikeFeed(
                                    widget.feedMenulis, user[3]);
                          },
                        ),
                        Text(widget.feedMenulis.like == null
                            ? "0"
                            : widget.feedMenulis.like.take(3).toString()),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.comment_outlined),
                              color: widget.feedMenulis.isComment == true
                                  ? Colors.blue
                                  : Colors.black,
                              onPressed: () {
                                buildAlertDialog();
                              },
                            ),
                            Text('Komentar')
                          ],
                        ),
                        StreamBuilder<List>(
                          stream: FeedMenulisCommentFirebaseApi
                              .readFeedMenulisComments(widget.feedMenulis),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator());
                              default:
                                if (snapshot.hasError) {
                                  return buildText(
                                      'Ada yang error, mohon dicoba lagi nanti ya');
                                } else {
                                  final feedMenuliss = snapshot.data;

                                  final provider =
                                      Provider.of<FeedMenulisProvider>(context);
                                  provider.setFeedMenulisComment(feedMenuliss);

                                  return feedMenuliss.isEmpty
                                      ? Center(
                                          child: Text(
                                            'Belum ada Komentar.',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        )
                                      : ListView.separated(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          padding: EdgeInsets.all(16),
                                          separatorBuilder: (context, index) =>
                                              Container(height: 8),
                                          itemCount: feedMenuliss.length,
                                          itemBuilder: (context, index) {
                                            final feedMenulisComment =
                                                feedMenuliss[index];
                                            // print('feedmenuliscomment');
                                            // print(feedMenulisComment.id);
                                            // print('feedmenulis');
                                            // print(widget.feedMenulis.id);
                                            // return FeedMenulisCommentWidget(
                                            //     feedMenulisComment:
                                            //         feedMenulisComment,
                                            //     feedMenulis:
                                            //         widget.feedMenulis);
                                            return user[7] == "Guru"
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: Slidable(
                                                      actionPane:
                                                          SlidableDrawerActionPane(),
                                                      key: Key(
                                                          feedMenulisComment
                                                              .id),
                                                      actions: [
                                                        IconSlideAction(
                                                          color: Colors.green,
                                                          onTap: () {
                                                            editAlertDialog(
                                                                feedMenulisComment);
                                                          },
                                                          caption: 'Ubah',
                                                          icon: Icons.edit,
                                                        )
                                                      ],
                                                      secondaryActions: [
                                                        IconSlideAction(
                                                          color: Colors.red,
                                                          caption: 'Hapus',
                                                          onTap: () =>
                                                              deleteFeedMenulisComment(
                                                                  context,
                                                                  feedMenulisComment),
                                                          icon: Icons.delete,
                                                        )
                                                      ],
                                                      child:
                                                          buildFeedMenulisComment(
                                                              context,
                                                              feedMenulisComment),
                                                    ),
                                                  )
                                                : buildFeedMenulisComment(
                                                    context,
                                                    feedMenulisComment);
                                          },
                                        );
                                }
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
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
                  buildComment(),
                  SizedBox(
                    height: 16,
                  ),
                  buildButton(),
                ],
              ));
        });
  }

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
            final komentar = FeedMenulisComment(
                id: DateTime.now().toString(),
                createdTime: DateTime.now(),
                description: _commentarController.text,
                writer: user[3]);

            final provider =
                Provider.of<FeedMenulisProvider>(context, listen: false);
            provider.commentFeed(widget.feedMenulis, komentar);
            _commentarController.text = '';
            Navigator.pop(context);
          },
          child: Text('Simpan'),
        ),
      );

  Widget buildFeedMenulisComment(BuildContext context, feedMenulisComment) {
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
                        feedMenulisComment.description,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            // backgroundImage: AssetImage('./assets/images/Logo.png'),
                            child: Container(
                              padding: EdgeInsets.all(6),
                              child: SvgPicture.network(
                                user[8],
                                semanticsLabel: 'Profil Pic',
                                placeholderBuilder: (BuildContext context) =>
                                    Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child:
                                            const CircularProgressIndicator()),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            user[3],
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500),
                          ),
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
      SnackBar(content: Text('feedMenulisComment dihapus')),
    );
  }

  editAlertDialog(feedMenulisComment) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Tambah komentar'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  editComment(feedMenulisComment),
                  SizedBox(
                    height: 16,
                  ),
                  buildButtonEdit(feedMenulisComment),
                ],
              ));
        });
  }

  Widget editComment(feedMenulisComment) {
    _commentarController.text = feedMenulisComment.description;
    return TextFormField(
      maxLines: 4,
      controller: _commentarController,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Komentar',
      ),
    );
  }

  Widget buildButtonEdit(feedMenulisComment) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: () {
            final provider =
                Provider.of<FeedMenulisProvider>(context, listen: false);
            provider.editCommentFeed(widget.feedMenulis, feedMenulisComment,
                _commentarController.text);
            // _commentarController.text = '';
            if (mounted) {
              setState(() {});
            }
            Navigator.pop(context);
          },
          child: Text('Simpan'),
        ),
      );
}
