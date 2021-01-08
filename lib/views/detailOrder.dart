import 'package:flutter/material.dart';

class DetailOrder extends StatefulWidget {
  var judul, nama, harga, status, yangOrder;
  DetailOrder({this.nama, this.judul, this.harga, this.status, this.yangOrder});
  @override
  _DetailOrderState createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        //automaticallyImplyLeading: false,
        title: Text('Riwayat order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(widget.judul)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(widget.nama)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(widget.harga)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(widget.status)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(widget.yangOrder)),
            ),
          ],
        ),
      ),
    );
  }
}
