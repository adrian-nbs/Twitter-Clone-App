import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/assets/twitter_icons.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'dart:math' as math;

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    Key? key,
    required this.myUserQuery,
  }) : super(key: key);

  final Query<Map<String, dynamic>> myUserQuery;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;
    final sd = math.sqrt(math.pow(sw, 2) + math.pow(sh, 2));
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverAppBar(
            shape: const ContinuousRectangleBorder(
              side: BorderSide(
                color: Color.fromRGBO(212, 216, 217, 1),
                width: 0.8,
              ),
            ),
            leadingWidth: sw * 0.112037037037037,
            leading: FirestoreQueryBuilder(
              query: widget.myUserQuery,
              builder: (context, snapshot, Widget? child) {
                if (snapshot.isFetching) {
                  return const Visibility(
                    visible: false,
                    child: SizedBox(),
                  );
                }
                if (snapshot.hasError) {
                  return Text('error ${snapshot.error}');
                }
                QueryDocumentSnapshot<Object?> data = snapshot.docs[0];
                return Padding(
                  padding: EdgeInsets.only(left: sw * 0.043287037037037),
                  child: GestureDetector(
                    child: CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.network(
                          data['urlAvatar'],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            title: const Text(
              'Notificaciones',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  TwitterIcons.settings,
                  size: sw * 0.0662037037037037,
                ),
                color: Colors.black,
                splashRadius: sw * 0.059837962962963,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
      body: const Center(),
    );
  }
}
