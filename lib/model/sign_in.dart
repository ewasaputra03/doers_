import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testlogin/detailprofile.dart';
import 'package:testlogin/orderan/buatOrder.dart';
import 'package:testlogin/orderan/listJasa.dart';

class SigninGoogle extends StatefulWidget {
  @override
  _SigninGoogleState createState() => _SigninGoogleState();
}

class _SigninGoogleState extends State<SigninGoogle> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;

  GoogleSignIn _googleSignIn = new GoogleSignIn();
  bool isSignIn = false;

  Future cekUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('isSignIn') != null) {
      setState(() {
        isSignIn = preferences.getBool('isSignIn');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();

    cekUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text("google Authentication"),
        ),
        body: isSignIn
            ? SingleChildScrollView(
                child: Column(
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
                                      image: _user.photoURL == null
                                          ? NetworkImage(
                                              'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png')
                                          : NetworkImage(_user.photoURL),
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
                                      _user.displayName,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      _user.email,
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
                      padding:
                          const EdgeInsets.only(left: 18, top: 12, bottom: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'My Doers',
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
                                    builder: (_) => DetailProfile()));
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => BuatOrder()));
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
                      padding:
                          const EdgeInsets.only(left: 18, top: 24, bottom: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Jual',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                    ),
                    Padding(
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
                    Padding(
                      padding: const EdgeInsets.only(left: 18, top: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            gooleSignout();
                          },
                          child: Text(
                            'Log Out',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: OutlineButton(
                  onPressed: () {
                    handleSignIn();
                    final User user = _auth.currentUser;
                    if (user == null) {
                      Scaffold.of(context).showSnackBar(const SnackBar(
                        content: Text('No one has signed in.'),
                      ));
                      return;
                    }
                  },
                  child: Text("SignIn with Goolge"),
                ),
              ));
  }

  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = (await _auth.signInWithCredential(credential));
    _user = result.user;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isSignIn', true);
  }

  Future<void> gooleSignout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        preferences.remove('isSignIn');
        isSignIn = true;
      });
    });
  }

  Future<User> getCurrentUser() async {
    User user = await _auth.currentUser;
    return user;
  }
}
