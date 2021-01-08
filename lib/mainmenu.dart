import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testlogin/edit/tes_profile.dart';
import 'package:testlogin/main.dart';
import 'package:testlogin/views/chatrooms.dart';
import 'package:testlogin/views/profile.dart';
import 'menuCari.dart';
import 'menuHome.dart';
import 'menuProfile.dart';
import 'orderan/listOrderan.dart';

class MainMenu extends StatefulWidget {
  final UserDetails userDetails;
  var uid;
  MainMenu({this.uid, Key key, @required this.userDetails}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  TabController _buttonBawah;

  String uidnya = '';
  String emailnya;

  Future cekLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString('uid', uidnya);
      print("cekid " + uidnya);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cekLogin();
    _buttonBawah = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: [
          MenuHome(),
          ChatRoom(),
          MenuCari(),
          ListOrderan(),
          profilePage(),
          // widget.uid == null
          //     ? TesProfile()
          //     : MenuProfile(uid: widget.uid)
        ],
        controller: _buttonBawah,
      ),
      bottomNavigationBar: TabBar(
        labelColor: Colors.amberAccent,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            //text: 'Home',
            icon: Icon(
              Icons.home,
              size: 24,
            ),
          ),
          Tab(
            // text: 'Pesan',
            icon: Icon(
              Icons.mail,
              size: 24,
            ),
          ),
          Tab(
            // text: 'Cari',
            icon: Icon(
              Icons.search,
              size: 24,
            ),
          ),
          Tab(
            // text: 'Notifikasi',
            icon: Icon(
              Icons.notifications,
              size: 24,
            ),
          ),
          Tab(
            // text: 'Profile',
            icon: Icon(
              Icons.person,
              size: 24,
            ),
          ),
        ],
        controller: _buttonBawah,
      ),
    );
  }
}
