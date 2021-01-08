import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testlogin/frontMenu/regis.dart';
import 'package:testlogin/frontMenu/signIn.dart';
import 'package:testlogin/mainmenu.dart';
import 'package:testlogin/model/sign_in.dart';

class FrontMenunya extends StatefulWidget {
  @override
  _FrontMenunyaState createState() => _FrontMenunyaState();
}

class _FrontMenunyaState extends State<FrontMenunya> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      body: SingleChildScrollView(
        child: Align( alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  'https://i.pinimg.com/originals/5a/72/d1/5a72d1363a52368e47e66b545699da90.jpg',
                  height: 150,
                  width: 150,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: ButtonTheme(
                    child: RaisedButton(
                        child: Text('LOGIN', style: TextStyle(color: Colors.white)),
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => signIn()));
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                    child: RaisedButton(
                        child: Text(
                          'DAFTAR',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => regisPage()));
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Text(
                      'Masuk Sebagai Tamu',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => MainMenu()));
                    },
                  ),
                ),
                SizedBox(height: 50),
                _signInButton(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
       Navigator.push(context, MaterialPageRoute(builder: (_) => SigninGoogle()));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: NetworkImage("https://drive.google.com/file/d/1t89PgqZjF6MUtz0SickqdFowJ3GQvM9e/view"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
