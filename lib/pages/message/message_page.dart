import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/assets/twitter_icons.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'dart:math' as math;

class MessagePage extends StatelessWidget {
  const MessagePage({
    Key? key,
    required this.myUserQuery,
  }) : super(key: key);

  final Query<Map<String, dynamic>> myUserQuery;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;
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
            centerTitle: true,
            leadingWidth: sw * 0.112037037037037,
            leading: FirestoreQueryBuilder(
              query: myUserQuery,
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
            title: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                fillColor: const Color.fromRGBO(239, 243, 244, 1),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                isDense: true,
                hintText: 'Buscar Mensajes Directos',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(212, 216, 217, 1),
                    width: 0.8,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(212, 216, 217, 1),
                    width: 0.8,
                  ),
                ),
                filled: true,
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
