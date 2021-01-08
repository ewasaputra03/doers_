import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testlogin/detailprofile.dart';
import 'package:testlogin/frontMenu/splashScreen.dart';
import 'package:testlogin/main.dart';
import 'package:testlogin/menuProfile.dart';
import 'package:testlogin/views/loadingPage.dart';

class BuatOrder extends StatefulWidget {
  var nama, email, noTelp, username;
  final UserDetails userdetails;
  BuatOrder(
      {this.nama, this.email, this.noTelp, this.username, this.userdetails});
  @override
  _BuatOrderState createState() => _BuatOrderState();
}

class _BuatOrderState extends State<BuatOrder> {
  File _image, _video, _image2, _image3;
  final _storage = FirebaseStorage.instance;
  String kategori = 'Rumah Tangga';
  String jasa = '';
  List kategoriJasa = [
    'Rumah Tangga',
    'Bangunan',
    'Tukang Cukur',
    'Otomotif',
    'Pengasuh',
  ];

  bool checkVal = false;
  bool loading = false;

  void getKategori(String s) {
    setState(() {
      kategori = s;
    });
  }

  Future _getImage() async {
    var img = await ImagePicker.pickImage(
        source: ImageSource
            .gallery); //ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = img;
      print('image$_image');
    });
  }

  Future _getImage2() async {
    var img = await ImagePicker.pickImage(
        source: ImageSource
            .gallery); //ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image2 = img;
      print('image$_image2');
    });
  }

  Future _getImage3() async {
    var i = await ImagePicker.pickImage(
        source: ImageSource
            .gallery); //ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image3 = i;
      print('image$_image3');
    });
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController judul, tag, harga, deskripsi; //, kategori
  DatabaseReference _ref, _referencePenyedia;

  TextEditingController nama = TextEditingController();
  TextEditingController notelp = TextEditingController();
  TextEditingController emailnya = TextEditingController();
  TextEditingController usernamenya = TextEditingController();

  @override
  void initState() {
    judul = TextEditingController();
    tag = TextEditingController();
    harga = TextEditingController();
    deskripsi = TextEditingController();
    nama.text = widget.nama;
    notelp.text = widget.noTelp;
    emailnya.text = widget.email;
    usernamenya.text = widget.username;
    jasa = kategori;
    _ref = FirebaseDatabase.instance.reference().child('Mission Board');
    _referencePenyedia =
        FirebaseDatabase.instance.reference().child('peneydiaJasa');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber,
              title: Text('Buat Mission'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: usernamenya,
                      //enabled: false,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return 'Username Tidak Boleh Kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'username ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailnya,
                      //enabled: false,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return 'Nama Tidak Boleh Kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'email ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nama,
                      // enabled: false,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return 'Nama Tidak Boleh Kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Nama ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: notelp,
                      //enabled: false,
                      validator: (String val) {
                        if (val.length < 8) {
                          return 'No Telpon tidak kurang';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'No Telpon',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: judul,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return 'Judul tidak boleh kosong';
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
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text('Pilih Kategori'),
                        isExpanded: true,
                        value: kategori, //Kategorinya,
                        items: kategoriJasa.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            getKategori(value);
                          });
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: deskripsi,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return 'Deskripsi tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Deskripsi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: tag,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return 'Tags tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Tags',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: harga,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return 'Tags tidak boleh kosong';
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
                    child: CheckboxListTile(
                        title: Text('NEGO'),
                        value: checkVal,
                        onChanged: (bool value) {
                          setState(() {
                            harga.text = 'Nego';
                            checkVal = value;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Foto',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Upload foto tentang pekerjaanmu',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    primary: false,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: _getImage,
                          child: Container(
                            color: Colors.black12,
                            child: _image == null
                                ? Icon(Icons.add)
                                : Image.file(_image),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: _getImage2,
                          child: Container(
                            color: Colors.black12,
                            child: _image2 == null
                                ? Icon(Icons.add)
                                : Image.file(
                                    _image2,
                                    height: 100,
                                    width: 100,
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: _getImage3,
                          child: Container(
                            color: Colors.black12,
                            child: _image3 == null
                                ? Icon(Icons.add)
                                : Image.file(_image3),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 38.0, right: 8, left: 8),
                    child: MaterialButton(
                      elevation: 5,
                      minWidth: double.maxFinite,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.lime,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() => loading = true);
                        saveMission().whenComplete(() => Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                                builder: (_) => SplashScreenya())));
                      },
                      child: Text(
                        'Pasang',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      //
                      elevation: 5,
                      minWidth: double.maxFinite,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.black12,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MenuProfile()));
                      },
                      child: Text(
                        'Batal',
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

  Future<void> saveMission() async {
    var snapshot, url;

    String namanya = nama.text;
    String noTelpnya = notelp.text;
    String Judulnya = judul.text;
    String Kategorinya = kategori;
    String Tagnya = tag.text;
    String Harganya = harga.text;
    String Deskripsinya = deskripsi.text;
    String email = emailnya.text;
    String username = usernamenya.text;

    snapshot = await _storage
        .ref()
        .child(Kategorinya)
        .child(Judulnya)
        .putFile(_image)
        .onComplete;
    url = await snapshot.ref.getDownloadURL();

    Map<String, String> jasanya = {
      'email': email,
      'nama': namanya,
      'noTelp': noTelpnya,
      'judul': Judulnya,
      'kategori': Kategorinya,
      'tag': Tagnya,
      'harga': Harganya,
      'deskripsi': Deskripsinya,
      'url': url,
      'username': username
    };
    _ref.push().set(jasanya);
    _referencePenyedia.push().set(jasanya);
  }

  uploadImage() async {
    var snapshot =
        await _storage.ref().child('jasa').putFile(_image).onComplete;
    var url = await snapshot.ref.getDownloadURL();
  }
}
