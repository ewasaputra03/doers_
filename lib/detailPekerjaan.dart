import 'dart:core';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/model/getUsername.dart';
import 'package:testlogin/services/database.dart';
import 'package:testlogin/views/search.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chat/chat.dart';
import 'helper/constants.dart';
import 'model/posts.dart';
import 'orderan/orderPage.dart';

class DetailPekerjaan extends StatefulWidget {
  @override
  _DetailPekerjaanState createState() => _DetailPekerjaanState();
  var nama,
      gambar,
      detail,
      namaPemasang,
      noTelp,
      username,
      userdetaiils,
      harga,
      email;

  DetailPekerjaan(
      {this.nama,
      this.gambar,
      this.detail,
      this.namaPemasang,
      this.noTelp,
      this.username,
      this.userdetaiils,
      this.harga,
      this.email});
}

class _DetailPekerjaanState extends State<DetailPekerjaan> {
  List<Posts> listUsername = [];
  DatabaseReference _ref;

  //var email, judul, harga;

  @override
  void initState() {
    super.initState();
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('Layanan Populer');

    _ref.once().then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      listUsername.clear();

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
        listUsername.add(p);
      }

      setState(() {
        print('length : $listUsername.length');
      });
    });
  }

  List dataContohReview = [
    {
      'nama': 'Mang Oleh',
      'pesan': 'rekomended?',
      'gambar':
          'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png'
    },
    {
      'nama': 'Odading',
      'pesan': 'bagus hasil rapi',
      'gambar':
          'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png'
    },
    {
      'nama': 'Iron Man',
      'pesan': 'pekerjaan bagu',
      'gambar':
          'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png'
    },
    {
      'nama': 'Iron Man',
      'pesan': 'pekerjaan bagu',
      'gambar':
          'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png'
    },
    {
      'nama': 'Iron Man',
      'pesan': 'pekerjaan bagu',
      'gambar':
          'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png'
    },
    {
      'nama': 'Iron Man',
      'pesan': 'pekerjaan bagu',
      'gambar':
          'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png'
    },
    {
      'nama': 'Iron Man',
      'pesan': 'pekerjaan bagu',
      'gambar':
          'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                width: 250,
                child: Image.network(
                  widget.gambar,
                  // fit: BoxFit.fill,
                  // height: 250,
                  // width: 250,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.namaPemasang,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        widget.noTelp,
                        style: (TextStyle(color: Colors.black)),
                      ),
                      Text('10 Jasa Terselesaikan',
                          style: (TextStyle(color: Colors.black)))
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.nama,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.detail),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        buttonColor: Colors.white70,
                        child: RaisedButton(
                          child: Text('Order'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          onPressed: () {
                            print('harga${widget.harga} email${widget.email} username${widget.username}' + widget.nama);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) =>
                                    OrderPage(
                                      email: widget.email,
                                      judul: widget.nama,
                                      harga: widget.harga,
                                      userDetails: widget.userdetaiils
                                    )));
                          },
                        ),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      buttonColor: Colors.white70,
                      child: RaisedButton(
                        child: Text('Chat'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Search(
                                        username:
                                            widget.username,
                                      )));
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      buttonColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      child: RaisedButton(
                        child: Text('Call'),
                        onPressed: () {
                          launch(('tel://${widget.noTelp}'));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 12),
                      child: Text(
                        'Review',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 12),
                    child: Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 12),
                    child: Text('5'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 12),
                    child: Text('(8)'),
                  )
                ],
              ),
              ListView.builder(
                  //scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataContohReview.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                          Image.network('${dataContohReview[index]['gambar']}'),
                      title: Text('${dataContohReview[index]['nama']}'),
                      subtitle: Text('${dataContohReview[index]['pesan']}'),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  DatabaseMethods databaseMethods = new DatabaseMethods();
  String userName;

  sendMessage() {
    List<String> users = [Constants.myName, userName];

    String chatRoomId = getChatRoomId(Constants.myName, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                )));
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
