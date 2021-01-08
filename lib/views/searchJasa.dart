import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/detailPekerjaan.dart';
import 'package:testlogin/model/posts.dart';
import 'package:testlogin/services/database.dart';

class SearchJasa extends StatefulWidget {
  @override
  _SearchJasaState createState() => _SearchJasaState();
}

class _SearchJasaState extends State<SearchJasa> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;
  DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('Layanan Terbaru');

  bool isLoading = false;
  bool haveUserSearched = false;

  List<Posts> list;

  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .searchByTag(searchEditingController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Colors.amberAccent,
                  // leading: Image.network(searchResultSnapshot.docs[index].data()["url"]),
                  // title: searchResultSnapshot.docs[index].data()["judul"],
                  //   subtitle: searchResultSnapshot.docs[index].data()["deskripsi"],
                  leading: Image.network(searchResultSnapshot.docs[index]
                      .data()["url"]
                      .toString()),
                  title: Text(searchResultSnapshot.docs[index]
                      .data()["judul"]
                      .toString()),
                  subtitle: Text(searchResultSnapshot.docs[index]
                      .data()["deskripsi"]
                      .toString()),

                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailPekerjaan(
                                  nama: searchResultSnapshot.docs[index]
                                      .data()["judul"],
                                  namaPemasang: searchResultSnapshot.docs[index]
                                      .data()["nama"],
                                  gambar: searchResultSnapshot.docs[index]
                                      .data()["url"],
                                  detail: searchResultSnapshot.docs[index]
                                      .data()["deskripsi"],
                                  noTelp: searchResultSnapshot.docs[index]
                                      .data()["noTelp"],
                                  username: searchResultSnapshot.docs[index]
                                      .data()["username"],
                                  harga: searchResultSnapshot.docs[index]
                                      .data()["harga"],
                                  email: searchResultSnapshot.docs[index]
                                      .data()["email"],
                                )));
                  },
                ),
              );
            })
        : Container();
  }

  Widget userTile(String judul, String deskripsi) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                deskripsi,
                style: TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(24)),
              child: Text(
                "Lihat Jasa",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? SafeArea(
            child: SingleChildScrollView(
                child: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      color: Colors.amber,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: searchEditingController,
                                decoration: InputDecoration(
                                    hintText: "search ...",
                                    fillColor: Colors.amberAccent,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              initiateSearch();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0xffffffff),
                                        const Color(0xffffffff)
                                      ],
                                      begin: FractionalOffset.topLeft,
                                      end: FractionalOffset.bottomRight),
                                  borderRadius: BorderRadius.circular(30)),
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.search),
                            ),
                          ),
                        ],
                      ),
                    ),
                    userList()
                  ],
                ),
              ),
            ),
    );
  }
}
