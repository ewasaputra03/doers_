import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testlogin/mainmenu.dart';
import 'package:testlogin/frontMenu/regis.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testlogin/services/auth.dart';
import 'package:testlogin/services/database.dart';
import 'package:testlogin/views/loadingPage.dart';

import 'helper/helperfunctions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var uid = preferences.getString('uid');
  runApp(MaterialApp(
    home: uid == null
        ? MyApp()
        : MainMenu(
            uid: uid,
          ),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authService = new AuthService();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool userIsLoggedIn, _isSuccess;
  SharedPreferences prefs;
  bool loading = false;
  String error = '';

  DatabaseMethods databaseMethods = DatabaseMethods();
  DatabaseReference refGoogle;

  FirebaseAuth _auth = FirebaseAuth.instance;
  User currentUser;

  GoogleSignIn _googleSignIn = new GoogleSignIn();
  bool isSignIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ButtonTheme(
                  minWidth: MediaQuery
                      .of(context)
                      .size
                      .width / 1,
                  buttonColor: Colors.amber,
                  child: RaisedButton(
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        setState(() => loading = true);
                        loginAcn();
                        dynamic result =
                        await _auth.signInWithEmailAndPassword(
                            email: email.text,
                            password: password.text);
                        if (result == null) {
                          setState(() =>
                            loading = false
                          );
                          error = 'User tidak terdaftar';
                        }
                      }
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.5,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0)),
                      color: Color(0xffffffff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.lightGreen,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                                color: Colors.black, fontSize: 18.0),
                          ),
                        ],
                      ),
                      onPressed: () {
                        _signInGoogle(context)
                            .then((User user) => print(user))
                            .catchError((e) => print(e));
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => regisPage()));
                    },
                    child: Text(
                      'Belum punya akun? Daftar Disini!',
                      style: TextStyle(color: Colors.blueAccent),
                    )),
              ),
              Visibility(
                visible: false,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ButtonTheme(
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width / 1,
                    buttonColor: Colors.amber,
                    child: RaisedButton(
                      onPressed: () {

                      },
                      child: Text(
                        'hapus',
                        style: TextStyle(color: Colors.white),
                      ),
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

  Future<void> loginAcn() async {
    final User user = (await auth.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    ))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      final user1 = auth.currentUser;
      final String uid = user1.uid;

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('uid', uid);

      await authService
          .signInWithEmailAndPassword(email.text, password.text)
          .then((result) async {
        if (result != null) {
          QuerySnapshot userInfoSnapshot =
          await DatabaseMethods().getUserInfo(email.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.docs[0].data()["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.docs[0].data()["userEmail"]);

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                MainMenu(
                  uid: uid,
                ),
          ));
        } else {
          setState(() {
            loading = false;
            //show snackbar
          });
        }
      });

      QuerySnapshot userInfoSnapshot =
      await DatabaseMethods().getUserInfo(email.text);

      HelperFunctions.saveUserLoggedInSharedPreference(true);
      HelperFunctions.saveUserNameSharedPreference(
          userInfoSnapshot.docs[0].data()["userName"]);
      HelperFunctions.saveUserEmailSharedPreference(
          userInfoSnapshot.docs[0].data()["userEmail"]);

      Navigator.pushReplacement(context,
        MaterialPageRoute(
          builder: (context) =>
              MainMenu(
                uid: uid,
              ),
        ),
      );
    } else {
      _isSuccess = false;
      loading = false;
    }
  }

  Future<User> _signInGoogle(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
    (await auth.signInWithCredential(credential));
    User userDetails = userCredential.user;
    ProviderDetails providerInfo = new ProviderDetails(userDetails.uid);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = new UserDetails(
      userDetails.uid,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );

    Map<String, String> userDataMap = {
      "userName": userDetails.displayName,
      "userEmail": userDetails.email
    };


    databaseMethods.addUserInfo(userDataMap);

    QuerySnapshot userInfoSnapshot =
    await DatabaseMethods().getUserInfo(userDetails.email);

    HelperFunctions.saveUserLoggedInSharedPreference(true);
    HelperFunctions.saveUserNameSharedPreference(
        userInfoSnapshot.docs[0].data()["userName"]);
    HelperFunctions.saveUserEmailSharedPreference(
        userInfoSnapshot.docs[0].data()["userEmail"]);


    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => MainMenu(),
      ),
    );
    return userDetails;
  }
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

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}
