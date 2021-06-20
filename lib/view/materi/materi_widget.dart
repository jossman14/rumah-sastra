import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:rusa4/Utils/utils.dart';
import 'package:rusa4/model/materi.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/materi_provider.dart';
import 'package:rusa4/view/materi/edit_materi.dart';
import 'package:rusa4/view/materi/see_materi.dart';

class MateriWidget extends StatelessWidget {
  final Materi materi;

  const MateriWidget({
    @required this.materi,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;

    return user[7] == "Guru"
        ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              key: Key(materi.id),
              actions: [
                IconSlideAction(
                  color: Colors.green,
                  onTap: () => editMateri(context, materi),
                  caption: 'Edit',
                  icon: Icons.edit,
                )
              ],
              secondaryActions: [
                IconSlideAction(
                  color: Colors.red,
                  caption: 'Delete',
                  onTap: () => deleteMateri(context, materi),
                  icon: Icons.delete,
                )
              ],
              child: buildMateri(context),
            ),
          )
        : buildMateri(context);
  }

  Widget buildMateri(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;
    return GestureDetector(
      onTap: () => seeMateri(context, materi),
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
                    ListTile(
                      title: Text(
                        materi.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Container(
                            padding: user[8][8] != "f"
                                ? EdgeInsets.all(12)
                                : EdgeInsets.all(4),
                            child: user[8][8] != "f"
                                ? Container(
                                    width: 30,
                                    height: 30,
                                    child: SvgPicture.network(
                                      user[8],
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
                                        image: NetworkImage(user[8]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(materi.writer,
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

  void deleteMateri(BuildContext context, Materi materi) {
    final provider = Provider.of<MateriProvider>(context, listen: false);
    provider.removeMateri(materi);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('materi dihapus')),
    );
  }

  void editMateri(BuildContext context, Materi materi) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditMateriPage(materi: materi),
        ),
      );
  void seeMateri(BuildContext context, Materi materi) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SeeMateriPage(materi: materi),
        ),
      );
}
