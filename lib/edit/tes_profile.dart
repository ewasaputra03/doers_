import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testlogin/form/detailProfileGoogle.dart';
import 'package:testlogin/orderan/buatOrder.dart';
import 'package:testlogin/orderan/listJasa.dart';

import '../main.dart';

class TesProfile extends StatefulWidget {
  // final UserDetails detailsUser;
  // var uid;
  // TesProfile({this.uid, Key key, @required this.detailsUser}) : super(key: key);
  @override
  _TesProfileState createState() => _TesProfileState();
}

class _TesProfileState extends State<TesProfile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User usernya;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  bool isSignIn = false;
  DateTime currentBackPressTime;
  DatabaseReference _ref;
  String uidnya = '';

  Future<bool> exitApp() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  //
  // Future cekUsernya() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     uidnya = preferences.getString('uid');
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernya = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: exitApp,
      child: Scaffold(
       // appBar: AppBar(title: Text("Profile google"),),
          body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.amber,
              height: 220,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(usernya.photoURL),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             usernya.displayName,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              usernya.email,
                              style: (TextStyle(color: Colors.white)),
                            ),
                            Text('10 Jasa Terselesaikan',
                                style: (TextStyle(color: Colors.white)))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 12, bottom: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Doers',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailProfileGoogle(
                                  nama: usernya.displayName,
                                  email: usernya.email,
                                  photoUrl: usernya.photoURL,
                                )));
                  },
                  child: Text(
                    'My Profile',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Favorit',
                ),
              ),
            ),

            //Text Order
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 24, bottom: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BuatOrder(
                                  nama: usernya.displayName,
                                  // userdetails: usernya.photoURL,
                              username: usernya.displayName,
                                )));
                  },
                  child: Text(
                    'Buat Misi',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Riwayat Order',
                ),
              ),
            ),

            //Text Jual
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 24, bottom: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Jual',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ListJasa()));
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Jasa Saya',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    gooleSignout().whenComplete(() => Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => MyApp())));
                  },
                  child: Text(
                    'Log Out',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> gooleSignout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        preferences.remove('uid');
        // isSignIn = true;
      });
    });
  }
}
