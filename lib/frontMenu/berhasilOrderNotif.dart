import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:testlogin/mainmenu.dart';

class BerhasilOrder extends StatefulWidget {
  @override
  _BerhasilOrderState createState() => _BerhasilOrderState();
}

class _BerhasilOrderState extends State<BerhasilOrder> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.amber,
      seconds: 3,
      navigateAfterSeconds: new MainMenu(),
      title:  Text(
        'Order Berhasil!', textAlign: TextAlign.center,
        style:  TextStyle(
            fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.white),
      ),
    );
  }
}
