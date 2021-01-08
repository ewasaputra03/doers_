import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testlogin/detailprofile.dart';
import 'package:testlogin/helper/push_notification.dart';
import 'package:testlogin/main.dart';
import 'package:testlogin/model/getemail.dart';
import 'package:testlogin/orderan/buatOrder.dart';
import 'package:testlogin/orderan/listJasa.dart';

class MenuProfile extends StatefulWidget {
  var uid;
  MenuProfile({this.uid});
  @override
  _MenuProfileState createState() => _MenuProfileState();
}

class _MenuProfileState extends State<MenuProfile> {

  int jasaSelesai = 10;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<GetEmail> list = [];

  String uidnya = '';
  String penjual = 'Beralih ke mode penjual';
  bool isSwitched = false;
  bool visible = true;

  User usernya;

  Future cekUsernya() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      uidnya = preferences.getString('uid');
    });
  }

  DatabaseReference _ref;

  var email;

  @override
  void initState() {
    cekUsernya();
    // TODO: implement initState
    super.initState();

    usernya = _auth.currentUser;
    final String uid = usernya.uid;
    email = usernya.email;

    _ref = FirebaseDatabase.instance.reference().child('user');
    _ref
        .orderByChild('email')
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      list.clear();

      for (var individualKeys in Keys) {
        GetEmail p = new GetEmail(
          Data[individualKeys]['nama'],
          Data[individualKeys]['email'],
          Data[individualKeys]['noTelp'],
          Data[individualKeys]['username'],
        );
        list.add(p);
      }

      setState(() {
        print('length : $list.length');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: usernya == null
          ? Center(child: Text("tidak ada user terdaftar"))
          : Stack(
              overflow: Overflow.visible,
              children: [
                Column(
                  children: [
                    Container(
                      color: Colors.amber,
                      height: 220,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 80),
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
                                          'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png'),
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
                                  child: ListView.builder(
                                    //physics: NeverScrollableScrollPhysics(),
                                    itemCount: list.length,
                                    itemBuilder: (context, index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          list[index].nama,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          list[index].email,
                                          style:
                                              (TextStyle(color: Colors.white)),
                                        ),
                                        Text(list[index].noTelp,
                                            style: (TextStyle(
                                                color: Colors.white)))
                                      ],
                                    ),
                                  ),
                                )
                              ],
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
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, top: 12, bottom: 12),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  // onTap: PushNotificationsManager(),
                                  child: Text(
                                    'My Doers',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
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
                                                  nama: list[index].nama,
                                                  email: list[index].email,
                                                  notelp: list[index].noTelp,
                                                )));
                                  },
                                  child: Text(
                                    'My Profile',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18, top: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Favorit',
                                ),
                              ),
                            ),

                            //Text Order
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, top: 24, bottom: 12),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Order',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
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
                                                  nama: list[index].nama,
                                                  noTelp: list[index].noTelp,
                                                  username:
                                                      list[index].username,
                                                  email: list[index].email,
                                                )));
                                  },
                                  child: Text(
                                    'Buat Misi',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18, top: 8.0),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ListJasa(
                                                  nama: list[index].nama,
                                                  notelp: list[index].noTelp,
                                                  username:
                                                      list[index].username,
                                                )));
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
                              padding:
                                  const EdgeInsets.only(left: 18, top: 38.0),
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

  Future<String> getEmail() async {
    User user = _auth.currentUser;
    String result = (await FirebaseDatabase.instance
            .reference()
            .child('user')
            .child(user.uid)
            .child('email')
            .once())
        .value;
    print(result);
    return result;
  }
}
