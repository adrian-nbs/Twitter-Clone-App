import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/assets/twitter_icons.dart';
import 'package:flutterfire/pages/home/tweet.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.tweetsQuery,
    required this.myUserQuery,
  }) : super(key: key);

  final Query<Map<String, dynamic>> tweetsQuery;
  final Query<Map<String, dynamic>> myUserQuery;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;
    final sd = math.sqrt(math.pow(sw, 2) + math.pow(sh, 2));
    return Scaffold(
      floatingActionButton: Theme(
        data: Theme.of(context)
            .copyWith(highlightColor: const Color.fromRGBO(142, 205, 248, 1)),
        child: FloatingActionButton(
          onPressed: () {},
          highlightElevation: 0,
          backgroundColor: const Color.fromRGBO(29, 155, 240, 1),
          splashColor: Colors.transparent,
          child: const Icon(Icons.add),
        ),
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
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
              title: Icon(
                TwitterIcons.logo,
                size: sw * 0.0636574074074074,
                color: const Color.fromRGBO(29, 155, 240, 1),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    TwitterIcons.featured,
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
        body: FirestoreListView<Map<String, dynamic>>(
          query: widget.tweetsQuery,
          padding: EdgeInsets.zero,
          itemBuilder: (context, snapshot) {
            Map<String, dynamic> tweets = snapshot.data();
            List<dynamic> imageSrc = tweets['tweet']['image'] ?? [''];
            String videoSrc = tweets['tweet']['video'] ?? '';
            bool showMedia = true;
            bool isOneImg = true;
            bool hasVideo = true;
            if (imageSrc[0] == '' && videoSrc == '') {
              showMedia = false;
            } else if (imageSrc.length > 1) {
              isOneImg = false;
            }
            if (videoSrc == '') {
              hasVideo = false;
            }
            if (tweets['tweet']['heightImg'] == null) {
              tweets['tweet']['heightImg'] = sd * 0.1886604398766648; //168.75
            }
            double heightImg = tweets['tweet']['heightImg'].toDouble();
            String src = tweets['tweet']['src'] ?? '';
            List<String> srcArray = [];
            if (src.contains('*')) {
              srcArray = src.split('*');
            } else {
              srcArray.add(src);
            }
            return Tweet(
              tweets: tweets,
              imageSrc: imageSrc,
              isOneImg: isOneImg,
              heightImg: heightImg,
              videoSrc: videoSrc,
              showMedia: showMedia,
              hasVideo: hasVideo,
              srcArray: srcArray,
              sw: sw,
              sd: sd,
              sh: sh,
            );
          },
        ),
      ),
    );
  }
}
