import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/feed_menulis_comment.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/feed_materi.dart';
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

  @override
  void initState() {
    super.initState();
    provider = Provider.of<EmailSignInProvider>(context, listen: false);

    user = provider.akun;
  }

  @override
  Widget build(BuildContext context) {
    return user[7] == "Guru"
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
                  caption: 'Edit',
                  icon: Icons.edit,
                )
              ],
              secondaryActions: [
                IconSlideAction(
                  color: Colors.red,
                  caption: 'Delete',
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
            final provider =
                Provider.of<FeedMenulisProvider>(context, listen: false);
            provider.editCommentFeed(widget.feedMenulis,
                widget.feedMenulisComment, _commentarController.text);
            // _commentarController.text = '';
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      );
}
