import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testlogin/helper/helperfunctions.dart';
import 'package:testlogin/mainmenu.dart';
import 'package:testlogin/services/database.dart';
import 'package:testlogin/views/loadingPage.dart';

class regisPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<regisPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController email, password, nama, noTelp, username;
  bool _isSuccess;
  DatabaseReference _ref;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool loading = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    email = TextEditingController();
    password = TextEditingController();
    nama = TextEditingController();
    noTelp = TextEditingController();
    username = TextEditingController();
    _ref = FirebaseDatabase.instance.reference();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : Scaffold(
            body: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                      child: Image.network(
                        'https://i.pinimg.com/originals/5a/72/d1/5a72d1363a52368e47e66b545699da90.jpg',
                        height: 150,
                        width: 150,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1,
                        child: TextFormField(
                          controller: username,
                          validator: (String val) {
                            if (val.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1,
                        child: TextFormField(
                          controller: email,
                          validator: (String val) {
                            if (val.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1,
                        child: TextFormField(
                          controller: nama,
                          validator: (String val) {
                            if (val.isEmpty) {
                              return 'Nama tidak boleh kosong!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Nama',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1,
                        child: TextFormField(
                          controller: noTelp,
                          validator: (String val) {
                            if (val.isEmpty) {
                              return 'Nomor telpon tidak boleh kosong';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'No Telpon',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1,
                        child: TextFormField(
                          controller: password,
                          validator: (String val) {
                            if (val.isEmpty) {
                              return 'password salah';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          obscureText: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width / 1,
                        buttonColor: Colors.amber,
                        child: RaisedButton(
                          onPressed: () {
                            if (_key.currentState.validate()) {
                              setState(() => loading = true);
                              regisAcn();
                              // regisAcn().whenComplete(() =>
                              //     Navigator.of(context)
                              //         .pushReplacement(MaterialPageRoute(
                              //             builder: (_) => MainMenu(
                              //                   uid: uidnyaini,
                              //                 ))));
                            } else {
                              setState(() => false);
                            }
                          },
                          child: Text(
                            'Daftar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Required';
    if (!regex.hasMatch(value))
      return '*Enter a valid email';
    else
      return null;
  }

  Future<void> regisAcn() async {
    final User user = (await auth.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    ))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      final user1 = auth.currentUser;
      final String uidnya = user1.uid;

      String emailnya = email.text;
      String namanya = nama.text;
      String noTelpnya = noTelp.text;
      String usernamenya = username.text;

      FirebaseFirestore.instance.collection('user').doc(user1.uid).set({
        'email': email.text,
        'displayName': nama.text,
        'phoneNumber': noTelp.text
      }).then((value) {
        setState(() {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => MainMenu(
                        uid: uidnya,
                      )));
        });
      });

      Map<String, String> info = {
        'uidnya': uidnya,
        'email': emailnya,
        'nama': namanya,
        'noTelp': noTelpnya,
        'username': usernamenya
      };

      _ref.child('user').push().set(info);

      Map<String, String> userDataMap = {
        "userName": username.text,
        "userEmail": email.text
      };

      databaseMethods.addUserInfo(userDataMap);

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('uid', uidnya);

      HelperFunctions.saveUserLoggedInSharedPreference(true);
      HelperFunctions.saveUserNameSharedPreference(username.text);
      HelperFunctions.saveUserEmailSharedPreference(email.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainMenu(
            uid: uidnya,
          ),
        ),
      );
    } else {
      _isSuccess = false;
    }
  }
}
