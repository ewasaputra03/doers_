import 'package:flutter/material.dart';

class MenuPesan extends StatefulWidget {
  @override
  _MenuPesanState createState() => _MenuPesanState();
}

class _MenuPesanState extends State<MenuPesan> {
  List data = [
    {
      'pengirim': 'Mang Oleh',
      'pesan': 'Hai, Bisa memperbaiki genteng yang rusak?',
      'waktu': '1 hari lalu'
    },
    {
      'pengirim': 'Odading',
      'pesan': 'Me : Lokasi dimana pak?',
      'waktu': '1 hari lalu'
    },
    {
      'pengirim': 'Iron Man',
      'pesan': 'Hai, Bisa memperbaiki pipa yang rusak?',
      'waktu': '1 hari lalu'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: Text('Pesan'),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: ListTile(
                leading: Image.network(
                    'https://static.thenounproject.com/png/212328-200.png'),
                title: Text('${data[index]['pengirim']}'),
                subtitle: Text('${data[index]['pesan']}'),
              ),
            );
          }),
    );
  }
}
