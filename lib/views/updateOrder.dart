import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/frontMenu/splashScreen.dart';
import 'package:testlogin/views/loadingPage.dart';

class UpdateOrder extends StatefulWidget {
  var judul, nama, harga, status, yangOrder;
  UpdateOrder({this.nama, this.judul, this.harga, this.status, this.yangOrder});
  @override
  _UpdateOrderState createState() => _UpdateOrderState();
}

class _UpdateOrderState extends State<UpdateOrder> {

  DatabaseReference _reference;
  DatabaseReference _ref;

  TextEditingController teksjudul = TextEditingController();
  TextEditingController teksnama = TextEditingController();
  TextEditingController teksharga = TextEditingController();
  TextEditingController teksstatus = TextEditingController();
  TextEditingController teksyangorder = TextEditingController();

  bool loading = false;

  DataSnapshot snapshot;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var key;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _ref = FirebaseDatabase.instance.reference().child('order');
    _reference = FirebaseDatabase.instance.reference().child('orderan');

    teksjudul.text = widget.judul;
    teksnama.text = widget.nama;
    teksharga.text = widget.status;
    teksstatus.text = widget.harga;
    teksyangorder.text = widget.yangOrder;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Order"),
        backgroundColor: Colors.amber,
      ),
      body: loading ? LoadingPage() : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: teksjudul,
                enabled: false,
                validator: (String val) {
                  if (val.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: teksnama,
                enabled: false,
                validator: (String val) {
                  if (val.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: teksharga,
                enabled: false,
                validator: (String val) {
                  if (val.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: teksstatus,
                validator: (String val) {
                  if (val.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: teksyangorder,
                enabled: false,
                validator: (String val) {
                  if (val.isEmpty) {
                    return 'Pengorder tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Pengorder',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0, left: 8, right: 8),
              child: MaterialButton(
                //
                elevation: 5,
                minWidth: double.maxFinite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.lime,
                textColor: Colors.white,
                onPressed: () {
                  setState(() => loading = true);
                  updateJasa().whenComplete(() => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SplashScreenya())));
                },
                child: Text(
                  'Update',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateJasa () async {
    String judul = teksjudul.text;
    String harga = teksharga.text;
    String email = teksnama.text;
    String status = teksstatus.text;
    String yangorder = teksyangorder.text;

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
