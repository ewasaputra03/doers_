import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:testlogin/frontMenu/regis.dart';
import 'package:testlogin/frontMenu/signIn.dart';

class UserNull extends StatefulWidget {
  @override
  _UserNUllState createState() => _UserNUllState();
}

class _UserNUllState extends State<UserNull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(
            'https://cdn.windowsreport.com/wp-content/uploads/2020/04/Login-Error-1200x1200.jpg',
            height: 150,
            width: 150,
          ),
          SizedBox(
            height: 15,
          ),
          PrimaryLineButton(
              title: 'LOGIN',
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => signIn()));
              }),
          SizedBox(
            height: 15,
          ),
          PrimaryLineButton(
              title: 'DAFTAR',
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => regisPage()));
              })
        ],
      ),
    );
  }
}
