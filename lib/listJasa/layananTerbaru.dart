import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/detailPekerjaan.dart';
import 'package:testlogin/model/posts.dart';

class LayananTerbaru extends StatefulWidget {
  @override
  _LayananTerbaruState createState() => _LayananTerbaruState();
}

class _LayananTerbaruState extends State<LayananTerbaru> {
  String judul, deskripsi, kategori, harga, tag, url;

  DatabaseReference _reflayanan = FirebaseDatabase.instance.reference();

  List<Posts> _list = [];

  @override
  void initState() {
    super.initState();

    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('Layanan Terbaru');

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
        title: Text('Layanan Terbaru'),
      ),
      body: GridView.builder(
        itemCount: _list.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DetailPekerjaan(
                      namaPemasang: _list[index].nama,
                      nama: _list[index].judul,
                      gambar: _list[index].url,
                      noTelp: _list[index].noTelp,
                      detail: _list[index].deskrpisi,
                      username: _list[index].username,
                    )));
              },
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridTile(
                      footer: Container(
                        color: Colors.white70,
                        child: Text(_list[index].judul),
                      ),
                      child: Container(
                          height: 150,
                          width: 150,
                          child: Image.network(_list[index].url))),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
