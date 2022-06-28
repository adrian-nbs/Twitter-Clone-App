import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/assets/twitter_icons.dart';
import 'package:flutterfire/pages/Notification/notification_page.dart';
import 'package:flutterfire/pages/Search/search_page.dart';
import 'package:flutterfire/pages/message/message_page.dart';
import 'pages/home/home_page.dart';

import 'dart:math' as math;


class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final myUserQuery = FirebaseFirestore.instance.collection('my_user');
  final tweetsQuery = FirebaseFirestore.instance.collection('tweets');
  int _currentIndex = 0;
  final List<Widget> _pages = [];

  @override
  void initState() {
    _pages.add(HomePage(tweetsQuery: tweetsQuery, myUserQuery: myUserQuery));
    _pages.add(SearchPage(myUserQuery: myUserQuery));
    _pages.add(NotificationPage(myUserQuery: myUserQuery));
    _pages.add(MessagePage(myUserQuery: myUserQuery));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sd = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(212, 216, 217, 1),
              width: 0.8,
            ),
          ),
        ),
        child: BottomNavigationBar(
          selectedIconTheme: const IconThemeData(
            color: Colors.black,
          ),
          unselectedItemColor: Colors.black,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            buildIconItem(
                sd, TwitterIcons.home, TwitterIcons.homeAlternate, 'Inicio', 0),
            buildIconItem(sd, TwitterIcons.search, TwitterIcons.searchAlternate,
                'Explorar', 1),
            buildIconItem(sd, TwitterIcons.notification,
                TwitterIcons.notificationAlternate, 'Notificaciones', 2),
            buildIconItem(sd, TwitterIcons.message,
                TwitterIcons.messageAlternate, 'Mensajes', 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem buildIconItem(
    double size,
    IconData iconTwitter,
    IconData iconTwitterAlternate,
    String labelTwitter,
    int i,
  ) {
    if (_currentIndex == i) {
      return BottomNavigationBarItem(
        icon: Icon(
          iconTwitterAlternate,
          size: size * 0.0268317070046812,
        ),
        label: labelTwitter,
      );
    }
    return BottomNavigationBarItem(
      icon: Icon(
        iconTwitter,
        size: size * 0.0268317070046812,
      ),
      label: labelTwitter,
    );
  }
}
