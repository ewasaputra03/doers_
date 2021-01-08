import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/detailPekerjaan.dart';
import 'package:testlogin/main.dart';
import 'package:testlogin/mainmenu.dart';
import 'package:testlogin/model/posts.dart';
import 'package:testlogin/orderan/buatJasa.dart';

class ListJasa extends StatefulWidget {
  var nama, notelp, username;
  final UserDetails userDetails;
  ListJasa({this.notelp, this.nama, this.username, this.userDetails});

  @override
  _ListJasaState createState() => _ListJasaState();
}

class _ListJasaState extends State<ListJasa> {
  String uidnya = FirebaseAuth.instance.currentUser.uid;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  List<Posts> _listUser = [];

  // Future<bool> _onBackPressed() {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (_) => MainMenu(
  //                 uid: uidnya,
  //             userDetails: widget.userDetails,
  //               )));
  // }

  var email;
  @override
  void initState() {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('peneydiaJasa');

    user = _auth.currentUser;
    email = user.email;

    _ref
        .orderByChild('email')
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _listUser.clear();

      for (var individualKeys in Keys) {
        Posts p = new Posts(
          Data[individualKeys]['nama'],
          Data[individualKeys]['noTelp'],
          Data[individualKeys]['judul'],
          Data[individualKeys]['deskripsi'],
          Data[individualKeys]['kategori'],
          Data[individualKeys]['harga'],
          Data[individualKeys]['tag'],
          Data[individualKeys]['url'],
          Data[individualKeys]['username'],
          Data[individualKeys]['email'],
        );
        _listUser.add(p);
      }

      setState(() {
        print('length : $_listUser.length');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: Text(
              'Jasa Saya',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: _listUser.length == 0
              ? Center(child: new Text('Tidak ada jasa terdaftar'))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _listUser.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Image.network(
                          _listUser[index].url,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                        title: Text(
                          _listUser[index].judul,
                          style: TextStyle(fontSize: 24),
                        ),
                        subtitle: Text(
                          _listUser[index].deskrpisi,
                          style: TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailPekerjaan(
                                nama: _listUser[index].judul,
                                gambar: _listUser[index].url,
                                detail: _listUser[index].deskrpisi,
                                noTelp: _listUser[index].noTelp,
                                namaPemasang: _listUser[index].nama,
                                username: _listUser[index].username,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                print('ini emailnya  ' + email);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BuatJasa(
                              nama: widget.nama == 0
                                  ? widget.nama
                                  : widget.userDetails.userName,
                              noTelp: widget.notelp,
                              email: email == 0
                                  ? widget.userDetails.userEmail
                                  : email,
                              username: widget.username == 0
                                  ? widget.username
                                  : widget.userDetails.userName,
                            )));
              }),
        ));
  }
}
