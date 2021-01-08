import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:testlogin/orderan/listJasa.dart';

class SplashScreenya extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenya> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.amber,
      seconds: 3,
      navigateAfterSeconds: new ListJasa(),
      title:  Text(
        'Jasa Berhasil di Pasang!', textAlign: TextAlign.center,
        style:  TextStyle(
            fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.white),
      ),
    );
  }
}

