import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testlogin/listJasa/layananPopuler.dart';
import 'package:testlogin/listJasa/layananTerbaru.dart';
import 'package:testlogin/listJasa/missionBoard.dart';
import 'package:testlogin/main.dart';
import 'package:testlogin/views/searchJasa.dart';

import 'detailPekerjaan.dart';
import 'model/posts.dart';

class MenuHome extends StatefulWidget {
  var userDetails;
  MenuHome({this.userDetails});
  @override
  _MenuHomeState createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  DatabaseReference _ref;

  List<Posts> _listPopuler = [];
  List<Posts> _listTerbaru = [];
  List<Posts> _listMisi = [];

  var email;
  @override
  void initState() {
    super.initState();

    //Take Layanan Popuer
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('Layanan Populer');

    _ref.once().then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _listPopuler.clear();

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
        _listPopuler.add(p);
      }

      setState(() {
        print('length : $_listPopuler.length');
      });
    });

    //Take Layanan Terbaru
    DatabaseReference _refTerbaru =
        FirebaseDatabase.instance.reference().child('Layanan Terbaru');

    _refTerbaru.once().then((DataSnapshot snapshot) {
      var KeysTerbaru = snapshot.value.keys;
      var DataTerbaru = snapshot.value;

      _listTerbaru.clear();

      for (var individualKeys in KeysTerbaru) {
        Posts p = new Posts(
          DataTerbaru[individualKeys]['nama'],
          DataTerbaru[individualKeys]['noTelp'],
          DataTerbaru[individualKeys]['judul'],
          DataTerbaru[individualKeys]['deskripsi'],
          DataTerbaru[individualKeys]['kategori'],
          DataTerbaru[individualKeys]['harga'],
          DataTerbaru[individualKeys]['tag'],
          DataTerbaru[individualKeys]['url'],
          DataTerbaru[individualKeys]['username'],
          DataTerbaru[individualKeys]['email'],
        );
        _listTerbaru.add(p);
      }

      setState(() {
        print('length : $_listTerbaru.length');
      });
    });

    //take Mission Board
    DatabaseReference _refMisi =
        FirebaseDatabase.instance.reference().child('Mission Board');

    _refMisi.once().then((DataSnapshot snapshot) {
      var KeysMisi = snapshot.value.keys;
      var DataMisi = snapshot.value;

      _listMisi.clear();

      for (var individualKeys in KeysMisi) {
        Posts p = new Posts(
          DataMisi[individualKeys]['nama'],
          DataMisi[individualKeys]['noTelp'],
          DataMisi[individualKeys]['judul'],
          DataMisi[individualKeys]['deskripsi'],
          DataMisi[individualKeys]['kategori'],
          DataMisi[individualKeys]['harga'],
          DataMisi[individualKeys]['tag'],
          DataMisi[individualKeys]['url'],
          DataMisi[individualKeys]['username'],
          DataMisi[individualKeys]['email'],
        );
        _listMisi.add(p);
      }

      setState(() {
        print('length : $_listMisi.length');
      });
    });
  }

  Future<void> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('uid');
  }

  @override
  Widget build(BuildContext context) {
    List<String> _searchList =
        List.generate(_listTerbaru.length, (index) => _listTerbaru[index].tag);

    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: InkWell(
            onTap: () {
              logOut().whenComplete(() => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => MyApp())));
            },
            child: Text('Doers')),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SearchJasa()));
              // showSearch(
              //     context: context,
              //     delegate: pencarian(
              //       _searchList,
              //     ));
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Layanan Populer',
                      style: TextStyle(fontSize: 18),
                    )),
              ),

              SizedBox(
                height: 250,
                child: _listPopuler.length == 0
                    ? Center(child: new Text('tidak ada jasa terdaftar'))
                    : ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        // itemCount: listberita.length,
                        itemCount: _listPopuler.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailPekerjaan(
                                  nama: _listPopuler[index].judul,
                                  gambar: _listPopuler[index].url,
                                  detail: _listPopuler[index].deskrpisi,
                                  noTelp: _listPopuler[index].noTelp,
                                  namaPemasang: _listPopuler[index].nama,
                                  username: _listPopuler[index].username,
                                  harga:  _listPopuler[index].harga,
                                  userdetaiils: widget.userDetails,
                                  email: _listPopuler[index].email,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                children: [
                                  (_listPopuler[index].url == null)
                                      ? Image.asset(
                                          'images/bangunan.png',
                                          height: 150,
                                          width: 150,
                                        )
                                      : Container(
                                          height: 150,
                                          width: 150,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              _listPopuler[index].url,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                  Container(
                                    height: 25,
                                    child: Text(
                                      _listPopuler[index].judul,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                      height: 30,
                                      child:
                                          Text(_listPopuler[index].deskrpisi)),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, right: 8),
                                      child: Text(
                                        'Rp. ' + _listPopuler[index].harga,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Lihat semua',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LayananPopuler()));
                  },
                ),
              ),

              //List Layanan Terbaru
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Layanan Terbaru',
                      style: TextStyle(fontSize: 18),
                    )),
              ),

              SizedBox(
                height: 260,
                child: _listTerbaru.length == 0
                    ? Center(child: new Text('tidak ada jasa terdaftar'))
                    : ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _listTerbaru.length,
                        //itemCount: listberita.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DetailPekerjaan(
                                          nama: _listTerbaru[index].judul,
                                          gambar: _listTerbaru[index].url,
                                          detail: _listTerbaru[index].deskrpisi,
                                          namaPemasang:
                                              _listTerbaru[index].nama,
                                          noTelp: _listTerbaru[index].noTelp,
                                      username: _listTerbaru[index].username,
                                      harga: _listTerbaru[index].harga,
                                      email: _listTerbaru[index].email,
                                        )));
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  children: [
                                    (_listTerbaru[index].url == null)
                                        ? Image.asset(
                                            'images/bangunan.png',
                                            height: 150,
                                            width: 150,
                                          )
                                        : Container(
                                            height: 150,
                                            width: 150,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                _listTerbaru[index].url,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                    Container(
                                      height: 25,
                                      child: Text(
                                        _listTerbaru[index].judul,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        height: 30,
                                        child: Text(
                                            _listTerbaru[index].deskrpisi)),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12.0, right: 8),
                                        child: Text(
                                          'Rp. ' + _listTerbaru[index].harga,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Lihat Semua',
                          style: TextStyle(color: Colors.blueAccent)),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LayananTerbaru()));
                  },
                ),
              ),

              //List Mission Board
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Mission Board',
                      style: TextStyle(fontSize: 18),
                    )),
              ),

              SizedBox(
                height: 260,
                child: _listMisi.length == 0
                    ? Center(child: new Text('tidak ada jasa terdaftar'))
                    : ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _listMisi.length,
                        //itemCount: listberita.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DetailPekerjaan(
                                          nama: _listMisi[index].judul,
                                          gambar: _listMisi[index].url,
                                          detail: _listMisi[index].deskrpisi,
                                          namaPemasang: _listMisi[index].nama,
                                          noTelp: _listMisi[index].noTelp,
                                      username: _listMisi[index].username,
                                      harga: _listMisi[index].harga,
                                        email: _listMisi[index].email,
                                        )));
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  children: [
                                    (_listMisi[index].url == null)
                                        ? Image.asset(
                                            'images/bangunan.png',
                                            height: 150,
                                            width: 150,
                                          )
                                        : Container(
                                            height: 150,
                                            width: 150,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                _listMisi[index].url,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                    Container(
                                      height: 25,
                                      child: Text(
                                        _listMisi[index].judul,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        height: 30,
                                        child:
                                            Text(_listMisi[index].deskrpisi)),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12.0, right: 8),
                                        child: Text(
                                          'Rp. ' + _listMisi[index].harga,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Lihat Semua',
                              style: TextStyle(color: Colors.blueAccent)),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MissionBoard()));
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class pencarian extends SearchDelegate {

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Cari data'),
      ),
    );
  }

  List<Posts> _recentList;
  final List<String> listExample;
  pencarian(this.listExample);

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Posts> _suggestionList = [];
    DatabaseReference _refTerbaru =
    FirebaseDatabase.instance.reference().child('Layanan Terbaru');

    _refTerbaru.once().then((DataSnapshot snapshot) {
      var KeysTerbaru = snapshot.value.keys;
      var DataTerbaru = snapshot.value;

      _suggestionList.clear();

      for (var individualKeys in KeysTerbaru) {
        Posts p = new Posts(
          DataTerbaru[individualKeys]['nama'],
          DataTerbaru[individualKeys]['noTelp'],
          DataTerbaru[individualKeys]['judul'],
          DataTerbaru[individualKeys]['deskripsi'],
          DataTerbaru[individualKeys]['kategori'],
          DataTerbaru[individualKeys]['harga'],
          DataTerbaru[individualKeys]['tag'],
          DataTerbaru[individualKeys]['url'],
          DataTerbaru[individualKeys]['username'],
          DataTerbaru[individualKeys]['email']
        );
        _suggestionList.add(p);
      }
    });
    _recentList = _suggestionList;
    query.isEmpty
        ? Text('tidak ada data yang ditemukan')
        : ListView.builder(
            itemCount: _recentList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(_suggestionList[index].url),
                title: Text(_suggestionList[index].judul),
                subtitle: Text(_suggestionList[index].deskrpisi),
                onTap: () {
                  selectedResult = _suggestionList[index].tag;
                  showResults(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DetailPekerjaan(
                                namaPemasang: _suggestionList[index].nama,
                                gambar: _suggestionList[index].url,
                                detail: _suggestionList[index].deskrpisi,
                                nama: _suggestionList[index].judul,
                                noTelp: _suggestionList[index].noTelp,
                              )));
                },
              );
            });
  }
}
