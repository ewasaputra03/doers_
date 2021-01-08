import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/model/getOrder.dart';
import 'package:testlogin/views/detailOrder.dart';
import 'package:testlogin/views/updateOrder.dart';

class ListOrderan extends StatefulWidget {
  @override
  _ListOrderanState createState() => _ListOrderanState();
}

class _ListOrderanState extends State<ListOrderan> {
  DatabaseReference _ref;
  DatabaseReference _reference;
  List<GetOrder> listnya = [];
  List<GetOrder> listYangOrder = [];
  var emailnya, emailPenyedia;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User usernya = _auth.currentUser;
    emailnya = usernya.email;
    emailPenyedia = usernya.email;
    _reference = FirebaseDatabase.instance.reference().child('order');
    _ref = FirebaseDatabase.instance.reference().child('order');

    _ref
        .orderByChild('yangOrder')
        .equalTo(emailnya)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      listYangOrder.clear();

      for (var individualKeys in Keys) {
        GetOrder p = new GetOrder(
          Data[individualKeys]['judul'],
          Data[individualKeys]['harga'],
          Data[individualKeys]['email'],
          Data[individualKeys]['status'],
          Data[individualKeys]['yangOrder'],
        );
        listYangOrder.add(p);
      }
      setState(() {
        print('length : $listYangOrder.length');
      });
    });

    _reference
        .orderByChild('email')
        .equalTo(emailPenyedia)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      listnya.clear();

      for (var individualKeys in Keys) {
        GetOrder p = new GetOrder(
          Data[individualKeys]['judul'],
          Data[individualKeys]['harga'],
          Data[individualKeys]['email'],
          Data[individualKeys]['status'],
          Data[individualKeys]['yangOrder'],
        );
        listnya.add(p);
      }
      setState(() {
        print('length : $listnya.length');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Order'),
          automaticallyImplyLeading: false,
        ),
        body: listnya.length == 0
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: listYangOrder.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 12, bottom: 12, right: 8),
                    child: ListTile(
                      leading: Image.asset(
                        'images/bangunan.png',
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        listYangOrder[index].judul,
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        listYangOrder[index].yangOrder,
                        style: TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => DetailOrder(
                                  nama: listYangOrder[index].email,
                                  judul: listYangOrder[index].judul,
                                  harga: listYangOrder[index].harga,
                                  status: listYangOrder[index].status,
                                  yangOrder: listYangOrder[index].yangOrder,
                                )));
                      },
                    ),
                  );
                })
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listnya.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 12, bottom: 12, right: 8),
                        child: ListTile(
                          leading: Image.asset(
                            'images/bangunan.png',
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                          ),
                          title: Text(
                            listnya[index].judul,
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            listnya[index].yangOrder,
                            style: TextStyle(fontSize: 14),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => UpdateOrder(
                                      nama: listnya[index].email,
                                      judul: listnya[index].judul,
                                      harga: listnya[index].harga,
                                      status: listnya[index].status,
                                      yangOrder: listnya[index].yangOrder,
                                    )));
                          },
                        ),
                      );
                    }),
              ));
  }
}
