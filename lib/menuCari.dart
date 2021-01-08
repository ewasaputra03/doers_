import 'package:flutter/material.dart';
import 'package:testlogin/listJasa/jasaBangunan.dart';
import 'package:testlogin/listJasa/jasaOtomotif.dart';
import 'package:testlogin/views/searchJasa.dart';

import 'listJasa/jasaRumahTangga.dart';

class MenuCari extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> namaKategori = ['Rumah tangga', 'Bangunan', 'Otomotif'];

    List dataCari = [
      {'nama': 'Rumah Tangga', 'gambar': 'rumahtangga.png'},
      {'nama': 'Bangunan', 'gambar': 'bangunan.png'},
      {'nama': 'Otomotif', 'gambar': 'car-parts.png'},
    ];

    List<String> _searchList =
        List.generate(dataCari.length, (index) => '${dataCari[index]['nama']}');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: Colors.amber,
        title: Text('Kategori'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SearchJasa()));
              //   showSearch(
              //       context: context, delegate: pencariannya(_searchList));
               })
        ],
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: dataCari.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12, right: 8),
              child: ListTile(
                leading: Image.asset(
                  'images/${dataCari[index]['gambar']}',
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  '${dataCari[index]['nama']}',
                  style: TextStyle(fontSize: 24),
                ),
                onTap: () {
                  if (dataCari[index]['nama'] == 'Rumah Tangga') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => JasaRumahTangga()));
                  } else if (dataCari[index]['nama'] == 'Bangunan') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => JasaBangunan()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => JasaOtomotif()));
                  }
                },
              ),
            );
          }),
    );
  }
}

class pencariannya extends SearchDelegate {
  final List list;
  pencariannya(this.list);

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
        child: Text(selectedResult),
      ),
    );
  }

  List _recentList = ['Text 4', 'Text 2'];

  @override
  Widget buildSuggestions(BuildContext context) {
    List _suggestionList = [];
    query.isEmpty
        ? _suggestionList = _recentList
        : _suggestionList
            .addAll(list.where((element) => element.contains(query)));

    return ListView.builder(
        itemCount: _suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
                'https://static.thenounproject.com/png/212328-200.png'),
            title: Text(_suggestionList[index]),
            onTap: () {
              selectedResult = _suggestionList[index];
              showResults(context);
            },
          );
        });
  }
}
