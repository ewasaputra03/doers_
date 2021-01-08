import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testlogin/mainmenu.dart';

class signIn extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<signIn> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  static TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isSuccess;


  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  validator: (String val) {
                    if (val.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                  ),
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ButtonTheme(

                  minWidth: MediaQuery.of(context).size.width / 2,
                  buttonColor: Colors.amber,
                  child: RaisedButton(
                    onPressed: () {
                      if (_key.currentState.validate()) {
                        regisAcn();
                      }
                    },
                    child: Text('Sign In', style: TextStyle(color: Colors.white),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void regisAcn() async {
    final User user = (await auth.signInWithEmailAndPassword(
      email: email.text,
      password: email.text,
    ))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      final user1 = auth.currentUser;
      final String uid = user1.uid;

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('uid', email.text);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MainMenu( uid: uid
          ),
        ),
      );
    } else {
      _isSuccess = false;
    }
  }
}
