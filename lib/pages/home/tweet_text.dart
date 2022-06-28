import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TweetText extends StatefulWidget {
  const TweetText({
    Key? key,
    required this.srcArray,
    required this.sw,
    required this.sh,
    required this.sd,
  }) : super(key: key);

  final List<String> srcArray;
  final double sw;
  final double sh;
  final double sd;

  @override
  State<TweetText> createState() => _TweetTextState();
}

class _TweetTextState extends State<TweetText> {
  List<InlineSpan> widgetSpanList = [];
  bool hasText = true;

  addValues() {
    if (widget.srcArray.length == 1) {
      widget.srcArray[0] = widget.srcArray[0].replaceAll('|', '\n');
      widgetSpanList.insert(
        0,
        TextSpan(
          text: widget.srcArray[0],
          style: TextStyle(
            fontSize: widget.sd * 0.015651829086064,
            letterSpacing: 0.2,
            color: const Color.fromRGBO(15, 20, 25, 1),
          ),
        ),
      );
    } else {
      for (int i = 0; i < widget.srcArray.length; i++) {
        widget.srcArray[i] = widget.srcArray[i].replaceAll('|', '\n');
        if (i % 2 == 0) {
          widgetSpanList.add(
            TextSpan(
              text: widget.srcArray[i],
              style: TextStyle(
                fontSize: widget.sd * 0.015651829086064,
                letterSpacing: 0.2,
                color: const Color.fromRGBO(15, 20, 25, 1),
              ),
            ),
          );
        } else if (widget.srcArray[i].contains('.') &&
            widget.srcArray[i].contains('/')) {
          String url = '';
          if (widget.srcArray[i].startsWith('https')) {
            url = widget.srcArray[i];
          } else if (widget.srcArray[i].startsWith('http')) {
            url =
            '${widget.srcArray[i].substring(0, 4)}s${widget.srcArray[i].substring(4, widget.srcArray[i].length)}';
          } else {
            url = 'https://${widget.srcArray[i]}';
          }
          widgetSpanList.add(
            WidgetSpan(
              child: InkWell(
                highlightColor: const Color.fromRGBO(237, 238, 240, 1),
                splashColor: const Color.fromRGBO(237, 238, 240, 1),
                onTap: () {
                  launchUrlString(url);
                },
                child: Text(
                  widget.srcArray[i],
                  style: TextStyle(
                    fontSize: widget.sd * 0.015651829086064,
                    letterSpacing: 0.2,
                    color: const Color.fromRGBO(29, 155, 240, 1),
                  ),
                ),
              ),
            ),
          );
        } else {
          widgetSpanList.add(
            WidgetSpan(
              child: InkWell(
                highlightColor: const Color.fromRGBO(237, 238, 240, 1),
                splashColor: const Color.fromRGBO(237, 238, 240, 1),
                onTap: () {},
                child: Text(
                  widget.srcArray[i],
                  style: TextStyle(
                    fontSize: widget.sd * 0.015651829086064,
                    letterSpacing: 0.2,
                    color: const Color.fromRGBO(29, 155, 240, 1),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    addValues();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.srcArray[0] == '') {
      hasText = false;
    }
    return RichText(
      text: TextSpan(
        children: hasText
            ? widgetSpanList
            : [
          const WidgetSpan(
            child: Visibility(
              visible: false,
              child: Center(),
            ),
          ),
        ],
      ),
    );
  }
}