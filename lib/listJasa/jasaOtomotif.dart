import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/model/posts.dart';

import '../detailPekerjaan.dart';

class JasaOtomotif extends StatefulWidget {
  @override
  _JasaOtomotifState createState() => _JasaOtomotifState();
}

class _JasaOtomotifState extends State<JasaOtomotif> {
  String judul,
      deskripsi,
      kategori,
      harga,
      tag,
      url,
      nama,
      notelp,
      username,
      email;

  DatabaseReference _reflayanan = FirebaseDatabase.instance.reference();

  List<Posts> _list = [];

  @override
  void initState() {
    super.initState();

    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('Otomotif');

    _ref.once().then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _list.clear();

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
        _list.add(p);
      }

      setState(() {
        print('length : $_list.length');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Otomotif'),
      ),
      body: Container(
        child: _list.length == 0
            ? Center(child: new Text('tidak ada jasa terdaftar'))
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      judul = _list[index].judul;
                      deskripsi = _list[index].deskrpisi;
                      kategori = _list[index].kategori;
                      harga = _list[index].harga;
                      tag = _list[index].tag;
                      url = _list[index].url;
                      nama = _list[index].nama;
                      notelp = _list[index].noTelp;
                      username = _list[index].username;
                      email = _list[index].email;

                      Map<String, String> jasanya = {
                        'nama': nama,
                        'noTelp': notelp,
                        'judul': judul,
                        'deskripsi': deskripsi,
                        'kategori': kategori,
                        'harga': harga,
                        'tag': tag,
                        'url': url,
                        'username': username,
                        'email': email
                      };
                      _reflayanan.child('Layanan Populer').push().set(jasanya);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DetailPekerjaan(
                                    gambar: url,
                                    nama: judul,
                                    detail: deskripsi,
                                    namaPemasang: nama,
                                    noTelp: notelp,
                                    harga: harga,
                                  )));
                    },
                    child: Card(
                      elevation: 5,
                      child: GridTile(
                        footer: Column(
                          children: [
                            Container(
                                child: Text(
                              _list[index].judul,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                            Container(
                                height: 25,
                                child: Text(_list[index].deskrpisi)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, right: 8),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Rp. ' + _list[index].harga,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 60.0, left: 8, right: 8, top: 8),
                          child: (_list[index].url == null)
                              ? AssetImage('images/car-parts.png')
                              : Image.network(
                                  _list[index].url,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
