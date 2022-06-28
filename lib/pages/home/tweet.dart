import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfire/pages/home/tweet_text.dart';
import 'package:video_player/video_player.dart';
import '../../assets/twitter_icons.dart';
import 'media_control.dart';

class Tweet extends StatefulWidget {
  const Tweet({
    Key? key,
    required this.tweets,
    required this.imageSrc,
    required this.isOneImg,
    required this.heightImg,
    required this.videoSrc,
    required this.showMedia,
    required this.hasVideo,
    required this.srcArray,
    required this.sw,
    required this.sh,
    required this.sd,
  }) : super(key: key);

  final Map<String, dynamic> tweets;
  final List<dynamic> imageSrc;
  final String videoSrc;
  final bool isOneImg;
  final bool showMedia;
  final bool hasVideo;
  final double heightImg;
  final List<String> srcArray;
  final double sw;
  final double sh;
  final double sd;

  @override
  State<Tweet> createState() => _TweetState();
}

class _TweetState extends State<Tweet> {
  final key = GlobalKey();
  late double heightImg;
  bool isStateRetweet = false;
  bool isStateFavorite = false;
  late Timer timer;
  int t = 300;
  Color? commentColor = const Color.fromRGBO(83, 100, 113, 1);
  Color? shareColor = const Color.fromRGBO(83, 100, 113, 1);
  Color? tweetColor = Colors.white;
  late int comments;
  late int retweets;
  late int favorites;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoSrc,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.initialize();
    heightImg = widget.heightImg;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        heightImg = key.currentContext?.size?.height as double;
        heightImg = heightImg - widget.sh*0.0105769230769231;
      });
    });
    comments = widget.tweets['tweet']['comments'];
    retweets = widget.tweets['tweet']['retweets'];
    favorites = widget.tweets['tweet']['favs'];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: tweetColor,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTapDown: (details) {
          setState(() {
            timer = Timer(const Duration(milliseconds: 300), resetTimer);
            tweetColor = const Color.fromRGBO(237, 238, 240, 1);
          });
        },
        onTapUp: (details) {
          setState(() {
            timer.cancel();
            changeTweetColor();
          });
        },
        onTapCancel: () {
          setState(() {
            tweetColor = Colors.white;
          });
        },
        child: Stack(
          alignment: Alignment.topRight,
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              right: -widget.sw * 0.0050925925925926,
              top: -widget.sh * 0.0105769230769231,
              child: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: const Color.fromRGBO(185, 202, 209, 1),
                  size: widget.sd * 0.0201237802535109,
                ),
                highlightColor: const Color.fromRGBO(237, 238, 240, 1),
                splashColor: const Color.fromRGBO(237, 238, 240, 1),
                splashRadius: widget.sd * 0.0268317070046812,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: widget.sh * 0.0012443438914027),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: widget.sh * 0.0105769230769231,
                      horizontal: widget.sw * 0.025462962962963,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: widget.sw * 0.0127314814814815),
                          child: Column(
                            children: [
                              GestureDetector(
                                child: CircleAvatar(
                                  radius: widget.sd * 0.0296266764843355,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(45),
                                    child: Image.network(
                                      widget.tweets['tweet']['user']
                                          ['urlAvatar'],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: widget.tweets['tweet']['showMH'],
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical:
                                            widget.sh * 0.0018665158371041,
                                      ),
                                      width: widget.sw * 0.0050925925925926,
                                      height: heightImg,
                                      color: const Color.fromRGBO(
                                          207, 217, 222, 1),
                                    ),
                                    GestureDetector(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(45),
                                        child: CircleAvatar(
                                          radius:
                                              widget.sd * 0.0173288107738566,
                                          child: Image.network(
                                            widget.tweets['tweet']['user']
                                                ['urlAvatar'],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: widget.sw * 0.0127314814814815,
                              right: widget.sw * 0.0221527777777778,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.tweets['tweet']['user']['name'],
                                      style: TextStyle(
                                        fontSize: widget.sd * 0.015651829086064,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.2,
                                        color:
                                            const Color.fromRGBO(15, 20, 25, 1),
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget.tweets['tweet']
                                          ['isVerified'],
                                      child: Icon(
                                        TwitterIcons.verified,
                                        size: widget.sd * 0.015651829086064,
                                        color: const Color.fromRGBO(
                                            29, 155, 240, 1),
                                      ),
                                    ),
                                    Text(
                                      ' @${widget.tweets['tweet']['user']['username']} • ${widget.tweets['tweet']['date']}',
                                      style: TextStyle(
                                        fontSize: widget.sd * 0.015651829086064,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.2,
                                        color: const Color.fromRGBO(
                                            83, 100, 113, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 1,
                                  ),
                                  child: Column(
                                    key: key,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                              widget.sh * 0.0037330316742081,
                                        ),
                                        child: TweetText(
                                          srcArray: widget.srcArray,
                                          sw: widget.sw,
                                          sh: widget.sh,
                                          sd: widget.sd,
                                        ),
                                      ),
                                      Visibility(
                                        visible: widget.showMedia,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxHeight:
                                                widget.sh * 0.497737556561086,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(14.0)),
                                            child: widget.hasVideo
                                                ? _controller
                                                        .value.isInitialized
                                                    ? buildVideo()
                                                    : Container(
                                                        height: 168.8,
                                                        color: Colors.black,
                                                      )
                                                : widget.isOneImg
                                                    ? buildImage()
                                                    : buildFourImages(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: widget.sh * 0.0099547511312217,
                                    bottom: widget.sh * 0.0111990950226244,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: buildCommentIcon(),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: buildRetweetIcon(),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: buildFavoriteIcon(),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: buildShareIcon(),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: widget.tweets['tweet']['showMH'],
                                  child: InkWell(
                                    highlightColor:
                                        const Color.fromRGBO(237, 238, 240, 1),
                                    splashColor:
                                        const Color.fromRGBO(237, 238, 240, 1),
                                    onTap: () {},
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: widget.sh * 0.0062217194570136,
                                        bottom: widget.sh * 0.0062217194570136,
                                      ),
                                      child: const Text(
                                        'Mostrar este hilo',
                                        style: TextStyle(
                                          letterSpacing: 0.2,
                                          color:
                                              Color.fromRGBO(29, 155, 240, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.8,
                    color: const Color.fromRGBO(212, 216, 217, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Table buildFourImages() {
    return Table(
      children: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 1.5, bottom: 1.5),
              child: InkWell(
                onTap: () {},
                child: Image.network(
                  widget.imageSrc[0],
                  height: widget.tweets['tweet']['heightImg'] / 2,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1.5, bottom: 1.5),
              child: InkWell(
                onTap: () {},
                child: Image.network(
                  widget.imageSrc[1],
                  width: double.infinity,
                  height: widget.tweets['tweet']['heightImg'] / 2,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 1.5, top: 1.5),
              child: InkWell(
                onTap: () {},
                child: Image.network(
                  widget.imageSrc[2],
                  width: double.infinity,
                  height: widget.tweets['tweet']['heightImg'] / 2,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1.5, top: 1.5),
              child: InkWell(
                onTap: () {},
                child: Image.network(
                  widget.imageSrc[3],
                  width: double.infinity,
                  height: widget.tweets['tweet']['heightImg'] / 2,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  InkWell buildImage() {
    return InkWell(
      onTap: () {},
      child: Image.network(
        widget.imageSrc[0],
        width: double.infinity,
        fit: BoxFit.fitWidth,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          return Container(
            height: widget.heightImg,
            color: Colors.black,
            child: child,
          );
        },
      ),
    );
  }

  AspectRatio buildVideo() {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          VideoPlayer(_controller),
          ControlsOverlay(controller: _controller),
        ],
      ),
    );
  }

  InkWell buildShareIcon() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          shareColor = Colors.grey;
          changeShareColor();
        });
      },
      child: Row(
        children: [
          const SizedBox(width: 2.5),
          Icon(TwitterIcons.share,
              color: shareColor, size: widget.sd * 0.0201237802535109),
        ],
      ),
    );
  }

  InkWell buildCommentIcon() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          commentColor = Colors.grey;
          changeCommentColor();
        });
      },
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Icon(
                TwitterIcons.comment,
                color: commentColor,
                size: widget.sd * 0.0201237802535109,
              ),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Text(
                comments == 0 ? ' ' : '  $comments',
                style: TextStyle(
                  fontSize: widget.sd * 0.0145338412942023,
                  color: commentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildRetweetIcon() {
    String sRetweets = retweets.toString();
    if (retweets > 999 && retweets <= 9999) {
      sRetweets =
          '${retweets.toString().substring(0, 1)},${retweets.toString().substring(1, 4)}';
    } else if (retweets > 9999 && retweets <= 999999) {
      if (sRetweets.length == 5) {
        sRetweets = '${retweets.toString().substring(0, 2)}K';
      } else if (sRetweets.length == 6) {
        sRetweets = '${retweets.toString().substring(0, 3)}K';
      }
    } else if (retweets > 999999) {
      if (sRetweets.length == 7) {
        sRetweets = '${retweets.toString().substring(0, 1)}M';
      } else if (sRetweets.length == 8) {
        sRetweets = '${retweets.toString().substring(0, 2)}M';
      } else if (sRetweets.length == 9) {
        sRetweets = '${retweets.toString().substring(0, 3)}M';
      }
    }
    if (isStateRetweet) {
      return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          setState(() {
            isStateRetweet = false;
            retweets--;
          });
        },
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  TwitterIcons.retweetAlternate,
                  color: const Color.fromRGBO(0, 186, 124, 1),
                  size: widget.sd * 0.0201237802535109,
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Text(
                  '  $sRetweets',
                  style: TextStyle(
                    fontSize: widget.sd * 0.0145338412942023,
                    color: const Color.fromRGBO(0, 186, 124, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          isStateRetweet = true;
          retweets++;
        });
      },
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Icon(
                TwitterIcons.retweet,
                color: const Color.fromRGBO(83, 100, 113, 1),
                size: widget.sd * 0.0201237802535109,
              ),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Text(
                sRetweets == '0' ? ' ' : '  $sRetweets',
                style: TextStyle(
                  fontSize: widget.sd * 0.0145338412942023,
                  color: const Color.fromRGBO(83, 100, 113, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildFavoriteIcon() {
    String sFavs = favorites.toString();
    if (favorites > 999 && favorites <= 9999) {
      sFavs =
          '${favorites.toString().substring(0, 1)},${favorites.toString().substring(1, 4)}';
    } else if (favorites > 9999 && favorites <= 999999) {
      if (sFavs.length == 5) {
        sFavs = '${favorites.toString().substring(0, 2)}K';
      } else if (sFavs.length == 6) {
        sFavs = '${favorites.toString().substring(0, 3)}K';
      }
    } else if (favorites > 999999) {
      if (sFavs.length == 7) {
        sFavs = '${favorites.toString().substring(0, 1)}M';
      } else if (sFavs.length == 8) {
        sFavs = '${favorites.toString().substring(0, 2)}M';
      } else if (sFavs.length == 9) {
        sFavs = '${favorites.toString().substring(0, 3)}M';
      }
    }
    if (isStateFavorite) {
      return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          setState(() {
            isStateFavorite = false;
            favorites--;
          });
        },
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  TwitterIcons.favoriteAlternate,
                  color: const Color.fromRGBO(249, 24, 128, 1),
                  size: widget.sd * 0.0201237802535109,
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Text(
                  '  $sFavs',
                  style: TextStyle(
                    fontSize: widget.sd * 0.0145338412942023,
                    color: const Color.fromRGBO(249, 24, 128, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          isStateFavorite = !isStateFavorite;
          favorites++;
        });
      },
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Icon(
                TwitterIcons.favorite,
                color: const Color.fromRGBO(83, 100, 113, 1),
                size: widget.sd * 0.0201237802535109,
              ),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Text(
                sFavs == '0' ? ' ' : '  $sFavs',
                style: TextStyle(
                  fontSize: widget.sd * 0.0145338412942023,
                  color: const Color.fromRGBO(83, 100, 113, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  changeCommentColor() async {
    await Future.delayed(
      const Duration(milliseconds: 400),
    );
    setState(() {
      commentColor = const Color.fromRGBO(83, 100, 113, 1);
    });
  }

  changeShareColor() async {
    await Future.delayed(
      const Duration(milliseconds: 400),
    );
    setState(() {
      shareColor = const Color.fromRGBO(83, 100, 113, 1);
    });
  }

  void resetTimer() {
    t = 0;
  }

  changeTweetColor() async {
    await Future.delayed(
      Duration(milliseconds: t),
    );
    setState(() {
      tweetColor = Colors.white;
      t = 300;
    });
  }
}
