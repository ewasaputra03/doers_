import 'package:flutter/material.dart';
import 'package:testlogin/edit/EditProfile.dart';
import 'package:testlogin/model/starRating.dart';

class DetailProfileGoogle extends StatefulWidget {
  var nama, email, photoUrl;
  DetailProfileGoogle({this.nama, this.email, this.photoUrl});
  @override
  _DetailProfileGoogleState createState() => _DetailProfileGoogleState();
}

class _DetailProfileGoogleState extends State<DetailProfileGoogle> {

  double rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Icon(Icons.settings),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => EditProfile()));
                    },
                  ))),
          Container(
            // height:200,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          //shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                widget.photoUrl),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              widget.nama,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 6),
                            child: Text(
                              widget.email,
                              style: (TextStyle(color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 6),
                            child: Text('Bangunan',
                                style: (TextStyle(color: Colors.black))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 6),
                            child: StarRating(
                              rating: rating,
                              onRatingChanged: (rating) =>
                                  setState(() => this.rating = rating),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Saya berpengalaman dibidang bangunan selama lebih dari 10 tahun, bisa bekerja secara individu ataupun dalam tim. '
                    'Terbiasa dalam tekanan, dan dapat bekerja sesuai target waktu yang diberikan.',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pendidikan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'SD Negeri 1 Bandar Lampung',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'SMP Negeri 1 Bandar Lampung',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'SMA Negeri 1 Bandar Lampung',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Portofolio',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
