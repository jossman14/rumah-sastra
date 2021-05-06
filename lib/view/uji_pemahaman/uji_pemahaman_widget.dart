import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/uji_pemahaman.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/provider/uji_pemahaman_provider.dart';
import 'package:rusa4/view/feed_menulis/edit_feed_menulis.dart';
import 'package:rusa4/view/feed_menulis/see_feed_menulis.dart';
import 'package:rusa4/view/uji_pemahaman/edit_uji_pemahaman.dart';
import 'package:rusa4/view/uji_pemahaman/see_uji_pemahaman.dart';

class UjiPemahamanWidget extends StatelessWidget {
  final UjiPemahaman ujiPemahaman;

  const UjiPemahamanWidget({
    @required this.ujiPemahaman,
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
              key: Key(ujiPemahaman.id),
              actions: [
                IconSlideAction(
                  color: Colors.green,
                  onTap: () => editUjiPemahaman(context, ujiPemahaman),
                  caption: 'Edit',
                  icon: Icons.edit,
                )
              ],
              secondaryActions: [
                IconSlideAction(
                  color: Colors.red,
                  caption: 'Delete',
                  onTap: () => deleteUjiPemahaman(context, ujiPemahaman),
                  icon: Icons.delete,
                )
              ],
              child: buildUjiPemahaman(context),
            ),
          )
        : buildUjiPemahaman(context);
  }

  Widget buildUjiPemahaman(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;
    return GestureDetector(
      onTap: () => seeUjiPemahaman(context, ujiPemahaman),
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
                        ujiPemahaman.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
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
                          Text(user[3],
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    // Text(
                    //   ujiPemahaman.title,
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     color: Theme.of(context).primaryColor,
                    //     fontSize: 22,
                    //   ),
                    // ),
                    // if (ujiPemahaman.description.isNotEmpty)
                    //   Container(
                    //     margin: EdgeInsets.only(top: 4),
                    //     child: Text(
                    //       ujiPemahaman.description,
                    //       style: TextStyle(fontSize: 20, height: 1.5),
                    //     ),
                    //   )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteUjiPemahaman(BuildContext context, UjiPemahaman ujiPemahaman) {
    final provider = Provider.of<UjiPemahamanProvider>(context, listen: false);
    provider.removeUjiPemahaman(ujiPemahaman);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('ujiPemahaman dihapus')),
    );
  }

  void editUjiPemahaman(BuildContext context, UjiPemahaman ujiPemahaman) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              EditUjiPemahamanPage(ujiPemahaman: ujiPemahaman),
        ),
      );
  void seeUjiPemahaman(BuildContext context, UjiPemahaman ujiPemahaman) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SeeUjiPemahamanPage(ujiPemahaman: ujiPemahaman),
        ),
      );
}
