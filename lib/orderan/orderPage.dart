import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/frontMenu/berhasilOrderNotif.dart';
import 'package:testlogin/mainmenu.dart';
import 'package:testlogin/views/loadingPage.dart';

class OrderPage extends StatefulWidget {
  var judul, email, harga, userDetails;
  OrderPage({this.judul, this.email, this.harga, this.userDetails});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool checkValue = false;
  bool loading = false;
  DatabaseReference _ref;

  DatabaseReference _reference;
  FirebaseAuth _auth;
  User user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('order');
    _reference = FirebaseDatabase.instance.reference().child('orderan');
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              title: Text('Order'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.judul,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.email,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Jasa',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.harga,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              )),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Biaya Tambahan',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('0',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Metode Pembayaran',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Checkbox(
                            activeColor: Colors.amber,
                            value: checkValue,
                            onChanged: (bool value) {
                              setState(() {
                                checkValue = value;
                              });
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          'Tunai',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Total',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.harga,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 38.0),
                    child: MaterialButton(
                      //
                      elevation: 5,
                      minWidth: double.maxFinite,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.amber,
                      textColor: Colors.white,
                      onPressed: () {
                        print('text' + widget.email);
                        setState(() => loading = true);
                        saveOrder().whenComplete(() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BerhasilOrder())));
                      },
                      child: Text(
                        'Order',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> saveOrder() async {
    String judul = widget.judul;
    String harga = widget.harga;
    String email = widget.email;
    String status = 'Menunggu Konfirmasi';
    String yangorder = user.email;

    Map<String, String> orderan = {
      'judul': judul,
      'harga': harga,
      'email': email,
      'status': status,
      'yangOrder': yangorder
    };
    _ref.push().set(orderan);
    _reference.push().set(orderan);
  }
}
