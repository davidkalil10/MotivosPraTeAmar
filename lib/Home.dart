import 'dart:core';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motivosprateamar/Historic.dart';
import 'package:motivosprateamar/Motivos.dart';
import 'package:motivosprateamar/Surprise.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<Widget> _pages = [Motivos(), Historic(),Surprise() ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffcdd4),
      bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.favorite, size: 30),
            Icon(Icons.history,size: 30),
            Icon(Icons.card_giftcard, size: 30),
          ],
        color: Colors.white,
        backgroundColor: Color(0xFFffcdd4),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFffcdd4),
        elevation: 0,
        title: Center(
          child: Text("Motivos pra te Amar!",
            style: GoogleFonts.gloriaHallelujah(
              color: Colors.black.withOpacity(0.8),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        child: _pages.elementAt(_page),
      ),
    );
  }
}
