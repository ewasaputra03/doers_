import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testlogin/orderan/buatOrder.dart';
import 'package:testlogin/orderan/listJasa.dart';

import '../detailprofile.dart';
import '../main.dart';

class profilePage extends StatefulWidget {
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  int jasaSelesai = 10;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String nama, nomortelpon, emailnya;
  String uidnya = '';
  String penjual = 'Beralih ke mode penjual';
  bool isSwitched = false;
  bool visible = true;

  User usernya;

  Future<DocumentSnapshot> getData() async {
    User login = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance.collection("user").doc(login.uid).get();
  }

  Future cekUsernya() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      uidnya = preferences.getString('uid');
    });
  }

  var email;

  @override
  void initState() {
    cekUsernya();
    // TODO: implement initState
    super.initState();

    usernya = _auth.currentUser;
    final String uid = usernya.uid;
    email = usernya.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: [
          Column(
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
                                    image: NetworkImage(
                                            'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png')
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                                height: 20,
                              ),
                              Container(
                                //color: Colors.white,
                                height: 100,
                                width: MediaQuery.of(context).size.width / 2,
                                child: FutureBuilder(
                                  future: getData(),
                                  builder: (context, snapshot) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30.0),
                                          child: Text(
                                            snapshot.data.data()['displayName'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.data()['email'],
                                          style: (TextStyle(color: Colors.white)),
                                        ),
                                        Text(snapshot.data.data()['phoneNumber'],
                                            style: (TextStyle(color: Colors.white)))
                                      ],
                                    );
                                  }
                                ),
                              )
                            ]
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(penjual),
                  ),
                  Spacer(),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        if (isSwitched == false) {
                          penjual = 'Beralih ke mode penjual';
                          visible = true;
                        } else if (isSwitched == value) {
                          penjual = 'Beralih ke mode pembeli';
                          visible = false;
                        } else {
                          return penjual;
                        }
                      });
                    },
                    activeColor: Colors.amber,
                    activeTrackColor: Colors.amberAccent,
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                // width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18, top: 12, bottom: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          // onTap: PushNotificationsManager(),
                          child: Text(
                            'My Doers',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
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
                                    builder: (_) => DetailProfile(
                                          nama: usernya.displayName,
                                          email: usernya.email,
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
                      padding:
                          const EdgeInsets.only(left: 18, top: 24, bottom: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Order',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
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
                                          username: usernya.displayName,
                                          email: usernya.email,
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
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Riwayat Order',
                          ),
                        ),
                      ),
                    ),

                    //Text Jual
                    Visibility(
                      visible: visible,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18, top: 24, bottom: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Jual',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visible,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => ListJasa()));
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Jasa Saya',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, top: 38.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            logOut().whenComplete(() =>
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MyApp())));
                            // signOutGoogle();
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('uid');
  }
}
